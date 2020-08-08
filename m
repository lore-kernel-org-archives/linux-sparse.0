Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217EBC433E1
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C6120716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y18WYNle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHHQL5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQL5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:11:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C6C061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:11:57 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f24so5168281ejx.6
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6W3Zwgq830k+6n2foagKBbA9PQmZ9LsVQps0k5iUjBY=;
        b=Y18WYNlefQkUdjSQvns3nOTmfX1kGQTGSc4VfwQLQhetrxetXDmETaU8PECYrNy0WG
         z4vcQ4BEExiPPnaRY5iY9aOMu1BRj5eKAr9+ogqrmCwabC8pw04bd7V6GZY6ba3x5HLk
         Q4k66wdP0oeRuxNMRJEFgMlEF20BIP8fH6POLfszJ9cb5z7BQA4ob838hC8UZPbFHk2D
         RMAvNRT9zKWpbqLwCeBAnWJUv40wGEAT1uD3XhjtTgGV6jywFFuwliEZEhXJkGHUFj2g
         A8e3GTFT/SN7cZBtG74L1yszaNQlXfHumxrY3tdeJ/mdd/hj5yTnTNX27UWWlCOpUUQN
         cOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6W3Zwgq830k+6n2foagKBbA9PQmZ9LsVQps0k5iUjBY=;
        b=H+0bYM6yRd5HgBQfb/CZt2tfVPdl/qc2fcB/TEUPtr1T9gIDNyCJSD8PbCmvzZcWYw
         9tfqE2TEbpotkotbIRDmVsh1a11EupZlkGFIGsbwiMIVeqZ0LFKIyLCxaJdohkZjjq+l
         1YyErpcVPMKf9NG/y8qwW62ZHLxCcpI6Nqu55iyWm68Q1wooRJ7dTN3Cl8EqOy8dHq6y
         0xlCPqt3vfXiS3+L7s1hgipoF8gRF5YYXUo1FW/rb566TW5nMMZTUpWOhYHjewcMgsRK
         WHtTx3WjCFnPvxkf0k+sQ4WAg3mK7dgUdUa1nsDekPtaWFzIP0+P50uxtFQPEBnYUucD
         6kAg==
X-Gm-Message-State: AOAM530PyhC8YJhabBkMIPKAFIYsxXRrRaNhNgqb3SKA+5XacXjn7NK7
        7fkL79KAwbG6K+OMRd7YLwNT/QE+
X-Google-Smtp-Source: ABdhPJyzWq0bGqqPUufCOiLYH94ros/XRdiRxOxwbuNcDVgUA2U2rtk29tKFdj1vyVoDbQQPaeBJjw==
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr14348358ejc.110.1596903115537;
        Sat, 08 Aug 2020 09:11:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:55 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] wstring: add support for evaluation of wide string
Date:   Sat,  8 Aug 2020 18:11:38 +0200
Message-Id: <20200808161143.28272-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Evaluation doesn't know about wide strings.

Fix this by:
1) selecting the right base type (char_ctype vs wchar_ctype)
2) adapting the type, size & alignment of the underlying array
   to this base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index dddea76182ad..acad11ab2712 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -102,9 +102,10 @@ static struct symbol *evaluate_string(struct expression *expr)
 	struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
 	struct expression *initstr = alloc_expression(expr->pos, EXPR_STRING);
 	unsigned int length = expr->string->length;
+	struct symbol *char_type = expr->wide ? wchar_ctype : &char_ctype;
 
 	sym->array_size = alloc_const_expression(expr->pos, length);
-	sym->bit_size = bytes_to_bits(length);
+	sym->bit_size = length * char_type->bit_size;
 	sym->ctype.alignment = 1;
 	sym->string = 1;
 	sym->ctype.modifiers = MOD_STATIC;
@@ -117,10 +118,10 @@ static struct symbol *evaluate_string(struct expression *expr)
 	initstr->string = expr->string;
 
 	array->array_size = sym->array_size;
-	array->bit_size = bytes_to_bits(length);
-	array->ctype.alignment = 1;
+	array->bit_size = sym->bit_size;
+	array->ctype.alignment = char_type->ctype.alignment;
 	array->ctype.modifiers = MOD_STATIC;
-	array->ctype.base_type = &char_ctype;
+	array->ctype.base_type = char_type;
 	array->examined = 1;
 	array->evaluated = 1;
 	
-- 
2.28.0

