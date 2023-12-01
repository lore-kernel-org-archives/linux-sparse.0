Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5pvzWur"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B276D6C
	for <linux-sparse@vger.kernel.org>; Fri,  1 Dec 2023 06:51:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33319741ba0so1938827f8f.1
        for <linux-sparse@vger.kernel.org>; Fri, 01 Dec 2023 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701442281; x=1702047081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhujmCbFgl8j0OnD6aZMpmkcYSFfMU69KqtJ2GCEJCc=;
        b=j5pvzWur70QGl2C3aEVsjT0XQCrhAY44NJw7ltMOUgwV7iTmA0a82nh++MKr8E4LSl
         X65XUVgdjbXdyOZJ70LdH7oNna5k51ciDDepnE5PovebVVWfEXc5xxoOp3n/vepM2Ea7
         XX9FY/6DVnLtxvOsnizEhUTQDpPvDVvyVv7Zz/BoRDQxVvLoDTOPaSxtBZmuUEs5iEpA
         uJDF/c6K4PDJ7Hc43ox6buX9CI6PjCxP2nUyfRUZQiJpSnWE7EqGG5O8o8KJU9AOM239
         sxhBJIcupX1vOgM+M22IugTXpqspk5U/6LVG2V36FIZvkOgPZZWKA2SFXUmsuOtCoAc4
         WBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442281; x=1702047081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhujmCbFgl8j0OnD6aZMpmkcYSFfMU69KqtJ2GCEJCc=;
        b=Tw8Ab1rG/NsTPnASI/9mINddxglCfDyiY9nv1Ezo97bwOUX1JLJ9LAu2OnINdNoTS7
         +lUdugMB9qU6kgKAvuzMJcp8j6+9iY8Gh8lY0iU95bCW+/HlcKKDUDjHQjv/IMSeZlOu
         ZHc3HMNoUxtq7bZfiB8S2PlD+2N/rqVN1f888AH14cP0ve92Nr84KrjHiwsejGgymOuO
         r/y4qp26sSm9d+y76NIz/EHeHaw11cuFqzz+O+OqEf3xuJ4rZejIuqkPZfiBjBzmcuf1
         plKIT8MKYYQIukHM2oNs8+VgZScW/m+XeTCn/iZ4QoHLr9NRm49ChSZaL3lvOop+gf3c
         ImWw==
X-Gm-Message-State: AOJu0YwByXdQooxcTZ7MNHuFtm644dbni+0luzgUIAUnkJdWRW05Cwo/
	es51zWjYSldCvW01YnwFq/VOKw==
X-Google-Smtp-Source: AGHT+IHRXXHuL3UXTG0ISrstrpBBPsA794z3wWwhMSdnmjNQywEEfBgcoFlAouyO6jcJ6iJZlx9wJg==
X-Received: by 2002:adf:e3c4:0:b0:333:149:68f1 with SMTP id k4-20020adfe3c4000000b00333014968f1mr926289wrm.70.1701442280920;
        Fri, 01 Dec 2023 06:51:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b003333281764bsm1462593wro.17.2023.12.01.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:51:20 -0800 (PST)
Date: Fri, 1 Dec 2023 17:51:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-sparse@vger.kernel.org
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
Message-ID: <17d4d1c1-6b27-4fab-bc94-9b2d734e7b36@suswa.mountain>
References: <202310080853.UhMe5iWa-lkp@intel.com>
 <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>

I patched Smatch to just ignore it.  I think Luc is on sabatical and
it's not clear if anyone is applying patches now.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 parse.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/parse.c b/parse.c
index 6803976a1337..2ddc29acbd33 100644
--- a/parse.c
+++ b/parse.c
@@ -74,6 +74,7 @@ static struct token *parse_range_statement(struct token *token, struct statement
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
 static struct token *parse_static_assert(struct token *token, struct symbol_list **unused);
+static struct token *ignore_seg_gs(struct token *token, struct symbol_list **unused);
 
 typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
@@ -354,6 +355,10 @@ static struct symbol_op static_assert_op = {
 	.toplevel = parse_static_assert,
 };
 
+static struct symbol_op seg_gs = {
+	.toplevel = ignore_seg_gs,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -521,6 +526,9 @@ static struct init_keyword {
 	N("_Float64x",		&spec_op,	.type = &float64x_ctype),
 	N("_Float128",		&spec_op,	.type = &float128_ctype),
 	N("__float128",		&spec_op,	.type = &float128_ctype),
+
+	N("__seg_gs",		&seg_gs),
+
 }, keywords[] = {
 	/* Statements */
 	N("if",			&if_op),
@@ -2130,6 +2138,11 @@ static struct token *parse_static_assert(struct token *token, struct symbol_list
 	return token;
 }
 
+static struct token *ignore_seg_gs(struct token *token, struct symbol_list **unused)
+{
+	return token->next;
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
-- 
2.42.0

