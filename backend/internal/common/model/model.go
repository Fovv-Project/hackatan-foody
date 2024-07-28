package model

import (
	"github.com/Fovv-Project/hackatan-service/internal/common/aws"
	"github.com/tmc/langchaingo/llms/bedrock"
)

var model *bedrock.LLM

func LoadModel() error {
	config, err := aws.NewAWS()
	if err != nil {
        return err
	}
	bedrockClient, err := bedrock.New(bedrock.WithClient(config),
		bedrock.WithModel("meta.llama3-1-405b-instruct-v1:0"))
	if err != nil {
        return err
	}
    model = bedrockClient
    return nil
}

func Get() *bedrock.LLM {
	return model
}
