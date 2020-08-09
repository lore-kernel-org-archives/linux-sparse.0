Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C631EC433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF76206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kftPkMxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHIUxg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIUxf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC670C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so4970636edy.5
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3+/1AhaeQwKQecDsEvoZWjlQ+B2CLc29C6mUV1Yxm8=;
        b=kftPkMxretYKiXBbIB0GnTHnPC3mQLkiBpPgchKlfcOacMpbtfpRS53SWpe6cKynAf
         /UVhzMxx7wmPYL2WRDsVlb38J0NlA18qntC31gT+pLkFgkCA8vIrx6FmgwbmRdOtODWn
         aAU5f05WNoeY86S0KA64lYc0f1hgJXXpdUNWbyNXlslM1pz/62EF/uOPYNYxKt3nHJmM
         5Hdbl83nTOKCHOK8DNX2clFkqlfeGtENfTJ3IE6xm9+za7MPGxxl1rbAU0sJEqK+KGD3
         mbpGYASKhCzEbY7ArBPplIkWvWfC9fhPtuhk5jWYpueEVwZYy/Nb1amj7iQCIVZtDkKh
         gE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3+/1AhaeQwKQecDsEvoZWjlQ+B2CLc29C6mUV1Yxm8=;
        b=TzRhwNfXwm21bNDqQcKBU6q/hIEoWFgONn+Uvp+kVzFRHXjkhD/jlEMwCBwpSPw8t5
         CrwkycIj9yxedPECHyUIzBLJuaR/DDqFVi+CxT1FdTFJiPfGa1FnCpEQPYM6hgPHa4qo
         MQuN9th7nowMaLktV4Z2Ot0ka1/S/Hu0j+NC+7/t8cmV3Lc11uJvpdq8J+xSDamY6u6+
         gMocQ9Q16UiL3ONOmr3vRgyi9fA68C5j/Yux/Ye/9x8b7XOQFsG16DftjYqS83PB1jWV
         yGwyv5hevNDSPz+r8hclBm4zmAb5JQD+uUHITlUfo8+aNH3VJJhIhfjCXXWnIbU6x3Xe
         l2GQ==
X-Gm-Message-State: AOAM532+OCOdJV0rzB/3Hrv7mtTZrgJZqdtZx0KQ8EjpCtMAInIKmuEW
        48krRMWC6mz56ocoQt8fB6hZ3qsa
X-Google-Smtp-Source: ABdhPJzzi7chU9Jh0NeHZs+FTYw7KyZ/hF1QbBnNgEZs2uQJ4DZzEdwXPFhXGChpdyMjLhT2u1inQw==
X-Received: by 2002:aa7:c45a:: with SMTP id n26mr18469033edr.45.1597006413113;
        Sun, 09 Aug 2020 13:53:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/10] separate parsing of asm-names from attributes
Date:   Sun,  9 Aug 2020 22:53:19 +0200
Message-Id: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series separate the parsing of asm-names from the parsing
of attributes. In itself this has not much value but this series
is part of a larger super-series aiming at rationalizing the
handling of attributes and modifiers.

Luc Van Oostenryck (10):
  use lookup_keyword() for qualifiers
  attribute: split handle_asm_name() from handle_attributes()
  attribute: fold parse_asm_declarator() into handle_asm_name()
  attribute: remove argument 'keywords' from handle_attributes()
  attribute: directly use attribute_specifier() to handle attributes
  attribute: factorize matching of '__attribute__'
  attribute: no need to lookup '__attribute__' in NS_KEYWORD
  testing for SYM_KEYWORD is unneeded for lookup_keyword()
  testing for sym->op is unneeded for lookup_keyword()
  keyword type is a bitmask and must be tested so

 parse.c | 103 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 49 deletions(-)


base-commit: ab77399f33b800f0a1568e512e86df71dd70f566
-- 
2.28.0

