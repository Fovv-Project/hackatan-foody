-- -------------------------------------------------------------
-- TablePlus 6.1.2(568)
--
-- https://tableplus.com/
--
-- Database: hackatan
-- Generation Time: 2024-07-28 10:58:15.0720
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS items_id_seq;

-- Table Definition
CREATE TABLE "public"."items" (
    "id" int4 NOT NULL DEFAULT nextval('items_id_seq'::regclass),
    "name" varchar,
    "description" varchar,
    "price" float4,
    "thumbnail" varchar,
    "restaurant_id" int8,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS labels_id_seq;

-- Table Definition
CREATE TABLE "public"."labels" (
    "id" int4 NOT NULL DEFAULT nextval('labels_id_seq'::regclass),
    "text" varchar,
    "restaurant_id" int8 NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS restaurants_id_seq;

-- Table Definition
CREATE TABLE "public"."restaurants" (
    "id" int4 NOT NULL DEFAULT nextval('restaurants_id_seq'::regclass),
    "name" varchar NOT NULL DEFAULT NULL::bpchar,
    "review_summary" varchar NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS reviews_id_seq;

-- Table Definition
CREATE TABLE "public"."reviews" (
    "id" int4 NOT NULL DEFAULT nextval('reviews_id_seq'::regclass),
    "sender" varchar NOT NULL,
    "text" varchar NOT NULL,
    "rating" float8 NOT NULL,
    "restaurant_id" int8 NOT NULL,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."labels" ("id", "text", "restaurant_id") VALUES
(159, 'Mcflurry', 3),
(160, 'Ayam', 3),
(161, 'HashBrown', 3),
(162, 'Mcfloat', 3),
(163, 'Mie Gacoan', 2),
(164, 'Udang Rambutan', 2),
(165, 'Siomay Ayam', 2),
(166, 'Cheeseburger', 3),
(167, 'Mcflurry', 3),
(168, 'HashBrown', 3),
(169, 'Mcfloat', 3),
(170, 'Ayam', 3),
(171, 'Udang Rambutan', 2),
(172, 'Mie Gacoan', 2),
(173, 'Siomay Ayam', 2),
(174, 'Cheeseburger Deluxe', 3),
(175, 'Mcflurry', 3),
(176, 'HashBrown', 3),
(177, 'Mcfloat', 3),
(178, 'Ayam', 3),
(179, 'Udang Rambutan', 2),
(180, 'Mie Gacoan', 2),
(181, 'Siomay Ayam', 2),
(182, 'Mie Pedas', 2),
(183, 'Mie Asin', 2),
(184, 'Mie Gurih', 2),
(185, 'Sushi', 6),
(186, 'Makanan Jepang', 6),
(187, 'Ramen', 6),
(188, 'Masakan Rumahan', 8),
(189, 'Cheeseburger', 3),
(190, 'Mcflurry', 3),
(191, 'HashBrown', 3),
(192, 'Mcfloat', 3),
(193, 'Ayam', 3),
(194, 'mie gacoan', 2),
(195, 'udang rambutan', 2),
(196, 'siomay ayam', 2);

INSERT INTO "public"."restaurants" ("id", "name", "review_summary") VALUES
(2, 'Mie Gacoan - Fatmawati', 'Mie gacoan ini memiliki rasa yang enak dan pedas, dengan udang yang juicy dan segar. Namun, beberapa reviewer mengalami masalah dengan tingkat kepedasan yang tidak sesuai dengan level yang dipesan. Selain itu, ada juga yang meminta perhatian lebih pada kebersihan kemasan.'),
(3, 'McDonald''s - Cinere', 'review-review yang diberikan memiliki pendapat yang beragam, namun secara umum pengguna puas dengan rasa dan kualitas makanan dari Mekdi, tetapi ada beberapa keluhan terkait dengan pengemasan, kesalahan pesanan dan kurangnya perhatian terhadap permintaan khusus pengguna.'),
(4, 'Ayam Gepuk Pak Gembus - Cirendeu Raya Pd Cabe', '-'),
(6, 'Genki Sushi', 'Tempat makan sushi yang lezat dan nyaman dengan pelayanan yang baik dan harga yang terjangkau. Cocok untuk makan siang bersama teman dan keluarga. Namun, ada beberapa menu yang biasa saja dan ramen yang kurang memuaskan.'),
(8, 'Warteg Bahari Soponyono', 'Fadel M menyukai tempat ini karena harganya yang murah tetapi kurang puas dengan rasa masakannya.');

INSERT INTO "public"."reviews" ("id", "sender", "text", "rating", "restaurant_id") VALUES
(1, 'titin.agstn', 'SEPERTII BIASA UDANG KEJUU NYAA JUARAA BANGET 💗 mie semua enakk rasanya pedes, asin, gurih', 5, 2),
(2, 'David F.', 'LV 1 aja udah pedes apalagi 8🥺', 5, 2),
(3, 'Kiki S.', 'good job... rasa masakannya sudah sesuai dengan standard mie gacoan... mie nya enak... tidak terlalu matang dan tidak terlalu mentah... udang rambutannya juicy fresh sekali seperti baru goreng👍👍👍, siomay ayamnya juga juicy sekali enak pokoknya yang cabang ini...', 5, 2),
(4, 'csmn', 'LV 2 Tapi seperti LV5 kayaknya ketuker atau salah buat, sering beli langsung pedesnya gaseparah ini', 1, 2),
(5, 'Citra', 'level 1 seperti lebih bukan level 1 pedesnya ga seperti biasanya', 4, 2),
(6, 'Emak L.', 'mantap enak murah🩷🩷🩷', 5, 2),
(7, 'Meyrna A.', 'tolong diperhatikan kebersihan kemasannya', 5, 2),
(8, 'Iman', 'Panas 2 krispy,medium,paket hemat cheeseburger deluxe, medium & mcflurry enak standard (Di pertahankan terus), tp sayang nasi putih gak di gabung dengan ayam malah di pisah & ayam nya bkn paha,gak di kasih sedotan minum pdhl udh minta & gak bs catatan request. Masukan saran nasi putih di gabung dgn ayam nya, di kasih/ada lagi sedotan minuman,paha sesuai yg di foto & bikin ada catatan request klu mau ganti dr paha ke ayam', 4, 3),
(9, 'Nur M.', 'Baru pertama kali ini pesanan datang kurang lengkap, HashBrown nya kurang 1 tapi sudah di refund via help center. Mohon lebih teliti lagi ke depan nya.', 3, 3),
(10, 'clara', 'mekdi tak pernah tidur, langgananku.. selalu mantaaab.. makasih yaa', 5, 3),
(11, 'tsani', 'aku minta dada di kasihnya paha :(', 4, 3),
(12, 'ella', 'promonya lumayan buat ank kos, pengemasan oke, mcfloatnya aman, ayamnya gede👍👍', 5, 3),
(13, 'Fadel M', 'Masakan nya kurang, seperti masakan rumahan, tetapi harganya tidak mahal, ayo beli rumah', 4, 8),
(18, 'Benhard M.', 'stafnya ramah dan membantu, tempatnya nyaman (baik untuk makan di tempat maupun untuk ngobrol dengan teman), makanannya lezat dan segar 💛', 4, 6),
(19, 'Evita H.', 'Sushi lezat dengan berbagai pilihan. Tempat yang cocok untuk makan siang bersama teman dan keluarga. Makanan dipesan dan diantar ke meja Anda menggunakan teknologi; cukup menyenangkan - anak-anak tampaknya menikmatinya.', 4, 6),
(20, 'Erik S.', 'Semua sushinya cukup enak. Sayangnya, yang lainnya biasa saja. Ramennya sungguh mengecewakan. Sangat mendekati mi instan dalam hal rasa dan kualitas mi/kuahnya.', 2, 6),
(21, 'Shakira Z.', 'Salah satu tempat favorit saya untuk makan sushi', 5, 6),
(22, 'Nurul H.', 'Salah satu restoran sushi favorit saya di kota ini. Porsinya besar, rasanya enak, harganya terjangkau, dan pelayanannya juga baik.', 5, 6);

ALTER TABLE "public"."items" ADD FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurants"("id");
ALTER TABLE "public"."items" ADD FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurants"("id");
ALTER TABLE "public"."labels" ADD FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurants"("id");
ALTER TABLE "public"."reviews" ADD FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurants"("id");
