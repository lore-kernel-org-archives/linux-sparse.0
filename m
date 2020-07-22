Return-Path: <SRS0=QBgf=BB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B6C433E3
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D472B22B3F
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIuCo87t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGVVvx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVVvx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jul 2020 17:51:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA794C0619DC
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:51:52 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so2915517edz.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhVCbWWwUXumgu111ZfU/IU5x/VA1zakNv1Mj5zJr8M=;
        b=GIuCo87t5RfujUHbE3/PykEUSLwRTnhwUeqTYEXvZHJR2QRH/858tAg48aHYuyDAEq
         MUqW/tuacBsrXCFAtFmpm8AszYdRVXHrLfa+vmHWMCsRuqUHZvXY+iSp3oR6AuziY+Bd
         0T6Yak+kyvAjmFETE0UazWPOw0YcOcMfhfKrrdIpxsZTRcGv2ezQ5YGD1NOVNvZeFviM
         fEoMJ0Utxrost0ydkxkYl/uG5N3wIzdZqcirENuTcrP/SIH9TrqcIyI1Fkg6pzhsk49G
         lOWxMwgoJvcaWUgfX0G3z5+xfGCQANesIaQEhzEHyonvly7odtlb0wtxbCx9jO0wwZcb
         B8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhVCbWWwUXumgu111ZfU/IU5x/VA1zakNv1Mj5zJr8M=;
        b=kMQ8wtqVl6dHhS6ofQnsKk73Pl93urC2u1duWEoEnLVW4rxrm4B8B+Fzf8lY3bSQUZ
         y35MIrfniCYjkFeRi+kMZ2YXokXgU+zVU4rbRlYFrHFVRRHi/EYV6zqdkZEMDIrlvUH6
         5LnwQf7mQCxukxqYavtgMbmZ5kH3ucsXz/kcQuFRGSSZxgnQT9rU68+L+Lv8cHrGo57Y
         WPqzH8bN5dRZrbOyjvg2VfBU7L8HLEmrBk+4xqV0twiMtHjBtDSp2W/8vPDc0NVJ4L7u
         XryA+aN7U+DTInu7jGfVIOKkkYb7UMpxgDRTiCsLb7QN+FuSPUvxQL6EZf8MZcbexGZX
         5DCA==
X-Gm-Message-State: AOAM532IR8RMB1BA3NlgelrPGt+guzEcRBSCnpfbfFspdCNdiJG8yvbO
        PNnSGWqS9toLZ3/qDfHQpi1qnZB4
X-Google-Smtp-Source: ABdhPJzRQdO+LR6DL1wDbQ/vYlJf1/94fh1lXs/UC2bhWXyHEk44iOwUL4agsyW3jQoJA6TqF7198g==
X-Received: by 2002:a05:6402:1c0f:: with SMTP id ck15mr1343163edb.155.1595454711292;
        Wed, 22 Jul 2020 14:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:905b:ad5c:bc87:c79e])
        by smtp.gmail.com with ESMTPSA id m6sm585382ejq.85.2020.07.22.14.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:51:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] attribute: simplify parsing of attributes
Date:   Wed, 22 Jul 2020 23:51:48 +0200
Message-Id: <20200722215148.37168-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In the loop doing the parsing of attributes, it's first checked
if EOF is reached, then if the token is ';' but these tests are
not needed since they're subsumed by the third one: checking if
the token is an identifier.

So, remove the tests for EOF and ';', and change the for-loop
into a while-loop checking for TOKEN_IDENT. As a bonus, remove
the local variable holding the identifier since it's there only
for historical reasons.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/parse.c b/parse.c
index cc5dbd522b3e..b07237eee0bf 100644
--- a/parse.c
+++ b/parse.c
@@ -1362,18 +1362,8 @@ static struct token *attribute_specifier(struct token *token, struct decl_state
 	token = expect(token, '(', "after attribute");
 	token = expect(token, '(', "after attribute");
 
-	for (;;) {
-		struct ident *attribute_name;
-		struct symbol *attr;
-
-		if (eof_token(token))
-			break;
-		if (match_op(token, ';'))
-			break;
-		if (token_type(token) != TOKEN_IDENT)
-			break;
-		attribute_name = token->ident;
-		attr = lookup_keyword(attribute_name, NS_KEYWORD);
+	while (token_type(token) == TOKEN_IDENT) {
+		struct symbol *attr = lookup_keyword(token->ident, NS_KEYWORD);
 		if (attr && attr->op->attribute)
 			token = attr->op->attribute(token->next, attr, ctx);
 		else
@@ -1784,13 +1774,7 @@ static struct token *skip_attributes(struct token *token)
 			break;
 		token = expect(token->next, '(', "after attribute");
 		token = expect(token, '(', "after attribute");
-		for (;;) {
-			if (eof_token(token))
-				break;
-			if (match_op(token, ';'))
-				break;
-			if (token_type(token) != TOKEN_IDENT)
-				break;
+		while (token_type(token) == TOKEN_IDENT) {
 			token = skip_attribute(token);
 			if (!match_op(token, ','))
 				break;
-- 
2.27.0

