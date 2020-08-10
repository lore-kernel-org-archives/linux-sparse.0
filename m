Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E3C433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EE4206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJUnpObW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHJVys (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVyq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104CC061756
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so10934419ejb.4
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsYWgjnoCq7jmh/iEc3W3dsbe17gaOmkLeKdtns2fpM=;
        b=XJUnpObWQZifsSFskaJKflhfOmpn4cXql1KxpsDXo6AzgODz+k9oggD96cJ1k98umD
         ysIIV/sWnlPl8PGvTmCkBPld6BzbZrfI58rtPQL1zmMRErrGLKZU3pk56Ee94VW7unFE
         qWVSo4Yce7U9UnljqT5Oqok+P0s7YbsjYa6dpK8F8JtrWBYkwvbfT/dlcwUDLGCczMUM
         ekfPPJ7TPulHwC8n8vAfTFFyv1PmCERv8j/AiOP8TQjiKLfLShoaoKwwLIzpG+pKog8E
         oRr7i4Y8nBT3HeqHQ+SWlXKw3QHAiQ9ba6nkRUDTpXU6yfYZP7OQC2l1a1SKZPlhXtJ5
         h+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsYWgjnoCq7jmh/iEc3W3dsbe17gaOmkLeKdtns2fpM=;
        b=CH1zUYPZeM8WHqbVwuzvVhJlKlsa2EZakGZK0CniUmTOkDR6TUFJswQTzesWKl6Jvk
         4yz0nXHn2ROnA94Qlp0E8eMmPBaRjr2AZkQUzdF5qdKB1Hhk5OuGdOi0RNHh2YJnU7xX
         T73qFSTbNTxRVeLbdbTc5QmfmI+2NG8kBGtKns+5Ro1d16zoMLt9GnCGPQIPFBscEo1R
         SoBYv6+RmAVRVLO31eAG9zf6Vnp03RKPLoabjjReB0JKvkFAtlquqENlsj5nI8sS4qmZ
         /p4EkalFfaAUZ52EHVegBgxmKZatF4JO1x4H2XIBPbGDPV8UFuC7RdStsRbTKosktVqc
         3gEw==
X-Gm-Message-State: AOAM532J6XzK0CnCM9CGQ8Vo8DisdS7XAH+hYaTxgOcuSJ+uc+cVRCvZ
        LaUhRXPOIXRpgW+C2QnD7DaLeTKH
X-Google-Smtp-Source: ABdhPJyYPALdJgVbdPIKgS9LBqDWD/BvA/LDjwKpwx2QKCVEeE/X2BRNOhH+eCDycNGhZpY/mycGMg==
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr22564401ejb.511.1597096484097;
        Mon, 10 Aug 2020 14:54:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/7] doc: move down info about tarballs, after git repositories
Date:   Mon, 10 Aug 2020 23:53:33 +0200
Message-Id: <20200810215336.76070-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Better to have the information about the GIT repositories
first because I'm not sure if anyone still use the tarballs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 4047343a5a75..321a947ec9c5 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -25,9 +25,6 @@ by Christopher Li in 2009 and by Luc Van Oostenryck in late 2018.
 Getting Sparse
 --------------
 
-You can find tarballs of released versions of Sparse at
-https://www.kernel.org/pub/software/devel/sparse/dist/.
-
 The most recent version can be obtained directly from the Git
 repository with the command::
 
@@ -35,6 +32,8 @@ repository with the command::
 
 You can also `browse the Git repository <https://git.kernel.org/pub/scm/devel/sparse/sparse.git>`_
 or use the mirror at https://github.com/lucvoo/sparse.
+The tarballs of released versions of Sparse and their signatures can be found at
+https://www.kernel.org/pub/software/devel/sparse/dist/.
 
 Once you have the sources, to build Sparse and install it in your ~/bin
 directory, just do::
-- 
2.28.0

