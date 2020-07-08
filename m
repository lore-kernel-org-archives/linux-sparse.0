Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A19C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996F520774
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQNPn98Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgGHT1A (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGHT1A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 15:27:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE742C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 12:26:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so51665914ejn.10
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/pbq2G4AK1nvqA5bVRpdZ96m3Ed2vv1c77XBCvIx4U=;
        b=QQNPn98ZW4KtmgytZb2uboHrZAw0QMihaAG1hNAK+m0JzDiyRL6eowY39kJ5jelrFj
         vspALlutDkXLIzaz6WrvFjcrEX6Ur1i/ST7cji988Kxd56jerr106p1OvVB9h4FOwbVp
         FPFaIdJLWKUEEGwQvgvdt9wAhEXI+2TeUbYA3uyx9f+Psn9PDmsxSfHtCDV0YrYt1pMy
         rbfoWMTlO5xARESyIqKQkYPKp/PObA/fYmLRIys8KUcRTKVE2Wmm4qWrz7fSEU5Ve96L
         ieLdOk7RlXSvli2+DesDXkhxkP4OVgYuQmSbmUKg2V/w1T27d1c6lcX25eKhFOn7a9ru
         UEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/pbq2G4AK1nvqA5bVRpdZ96m3Ed2vv1c77XBCvIx4U=;
        b=ZNV92INxpqMTEgJ2y202ovfZoEfU2FPAjLX0P8tyoro9KUstjO5R0fyyojbSaHc3U7
         FyokjuriIf4rVV+pWp66x8CvWtnEB+bZYKspYPVfUCRQIx8HhzalQbTRbzWSWgx8gZoz
         WYP+ui+ClGTRPeU0KzSHKxJQgOTh8d/BiQt3Jd8fh0hbm5vAaM5hAvQh3cMXnDM5xqon
         wTh20XA2vAOlQXjscthAjQ3z8Q6NMEZ+o10xtarAPIpDzdkJ7aIYFN+KcC5JuyJ/9WWe
         lgqVbUJM8XzSj6BecMMY3vDJtZhTkeqFjxkrdu0YlMrPJ/gfN//Kf+ep63hspckDw36B
         VTbg==
X-Gm-Message-State: AOAM530oRsfawfmFYG9AiCC/I+6lFUQletLgsRU1zqYgsr0aee8UhcuJ
        kv71qP0t5BmYJcDo3CPQCQLsh0e9
X-Google-Smtp-Source: ABdhPJybgNtAPgn4GlchPMViQhooAqtwjm8GESmWpmoDJutX6KuARjWyrZsZUYuMi/BetiNm4IkWIQ==
X-Received: by 2002:a17:906:774d:: with SMTP id o13mr47563912ejn.373.1594236417970;
        Wed, 08 Jul 2020 12:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id cc9sm372970edb.14.2020.07.08.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:26:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] make the keyword table more readable
Date:   Wed,  8 Jul 2020 21:26:51 +0200
Message-Id: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a three-easy-steps series to improve the readability
of the keyword table.

Luc Van Oostenryck (3):
  keyword: reorganize the keyword table
  keyword: reorder the keywords
  keyword: use some macros to avoid duplication

 parse.c | 286 ++++++++++++++++++++++++++------------------------------
 1 file changed, 132 insertions(+), 154 deletions(-)

-- 
2.27.0

