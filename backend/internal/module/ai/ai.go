package ai

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/Fovv-Project/hackatan-service/internal/common/model"
	"github.com/Fovv-Project/hackatan-service/internal/module/foody"
	"github.com/tmc/langchaingo/llms"
)

type (
	GenAi interface {
		getLabelSuggestion(string, []string) ([]string, error)
		generateReview([]string) (string, error)
		extractLabelFromReviews([]string) ([]string, error)
	}

	GenAiImpl struct{}
)

func CreateNewGenAiService() *GenAiImpl {
	return &GenAiImpl{}
}

func (ci *GenAiImpl) GenerateReview(reviews []foody.Review) (string, error) {
	var reviewString strings.Builder
	for i, review := range reviews {
		reviewString.WriteString(fmt.Sprintf("%d. %s\n", i+1, review))
	}

	kalimat := fmt.Sprint(`
    anda adalah sebuah mesin yang dapat merangkum suatu kumpulan review menjadi satu buah review,
    berikan response berupa json seperti berikut {"summary": "contoh1"}, berikut data review yang ada:
    `, reviewString.String())

	llm := model.Get()

	jsonResponse, err := llms.GenerateFromSinglePrompt(context.Background(), llm, kalimat)
	if err != nil {
		return "", err
	}

	var response GeneratedSummary

	err = json.Unmarshal([]byte(jsonResponse), &response)
	if err != nil {
		return "", err
	}

	return response.Summary, nil
}

func (ci *GenAiImpl) GetLabelSuggestion(input string, label []string) ([]string, error) {
	kalimat := fmt.Sprintf(`
    anda adalah sebuah mesin yang dapat memberikan rekomendasi label yang cocok berdasarkan kalimat yang di berikan,
    berikan response berupa json seperti berikut:
	{"label": ["contoh1", "contoh2"]}

    label: %s
    input: %s
    `, strings.Join(label, ", "), input)

	llm := model.Get()

	jsonResponse, err := llms.GenerateFromSinglePrompt(context.Background(), llm, kalimat)
	if err != nil {
		return nil, err
	}

	var response GeneratedLabel
	err = json.Unmarshal([]byte(jsonResponse), &response)
	if err != nil {
		return nil, err
	}
	return response.Label, nil
}

func (ci *GenAiImpl) ExtractLabelFromReviews(reviews []foody.Review) ([]string, error) {
	var reviewString strings.Builder
	for i, review := range reviews {
		reviewString.WriteString(fmt.Sprintf("%d. %s\n", i+1, review.Text))
	}

	prompt := fmt.Sprintln(`
    anda dapat merangkum lalu mengekstraksi label berdasarkan sejumlah review restoran,
    setiap label tidak memiliki kata sifat, setiap label minimal memiliki 1 kata dan maksimal 2 kata,
    prioritaskan label yang mendefinisikan jenis makanan atau nama makanan, dan tidak duplikat.
    berikan jawaban dengan template JSON seperti berikut:
    { "label": [] }
    properti label merupakan array string berisi label, dengan length maximal 10 label,
	jika memang tidak dapat membuat label, isi value properti label dengan array kosong saja.
	ingat, jawab dengan template format JSON yang telah disediakan saja!
    berikut sejumlah review untuk restoran:
    `, reviewString.String())

	llm := model.Get()
	jsonResponse, err := llms.GenerateFromSinglePrompt(context.Background(), llm, prompt)
	if err != nil {
		return nil, err
	}

	fmt.Println(jsonResponse)

	var response GeneratedLabel
	err = json.Unmarshal([]byte(jsonResponse), &response)
	if err != nil {
		return nil, err
	}
	return response.Label, nil
}
