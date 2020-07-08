Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E59C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A2720775
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkO/yWGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgGHXmE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGHXmE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC11C08C5CE
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so295296ejc.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oi9TH9+OA6xRT+h0p0vSYoquu9Dfx2RTKFYz5Asnrk0=;
        b=hkO/yWGLyrq4leEcNBWxUMTfw+n4K3974FkjedhDMzo0zJktF7P8R5Mg2lHA55HXJs
         eMyDgYA+My2vEX5v5o8MnvZUG1rEXQCkhiYFH81tbTd1sXDzxym/VB5hc6vNQV2pIFey
         Ni1LvUcVPPl2N4bpuVor/zgnTyRNVfUUhqUNbFVbjqu97ODVLfeiEE1bJgqYaD1boZDV
         vwapHKJzpZ9jsn3rwmVokgFB6OjYIX8C+KCljpXzdK1tXns+DpSkrUD3mywxSQ90ZIvW
         Kd90FdXojFdW9WLVEJt29vS2pbae4i6oRI8E2mH4AO1gSvZMrnDhdkJint+/P+IfUg6D
         bD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oi9TH9+OA6xRT+h0p0vSYoquu9Dfx2RTKFYz5Asnrk0=;
        b=uERqE8gD2OU2VwqfUOPcsAqrMa1DsDm0YAiTaGsmudckoPeGUdr9CFhMAlvlNDyA7t
         3ghWEkONwnitj1mZF9FBlakPrfTyr3gFKx5xsjnI/qTt353pbw+eVZLSLx66xtW3ijgd
         qFkInnMUixdD/Uv4IiYwJEl8cTHgNLfSHriX4h2SEDSwoAav4XZ4wZiuHmZX5IB+Zbwv
         9z4Tz87KrTtb1gySQY/4Oa2ZTbBZa5BQMvj3rI/6BOmFz+ad75760QYTRypBPNCd8Pn/
         wTnaHq56Zje9rCLgkAF1oLK5Urm+/4w04ujhTUSvbUDaLO8w267ZjWt4+b48KmSA5bzZ
         mPcA==
X-Gm-Message-State: AOAM531ALM8me+WVK94F9VmBfZtU8CYEAweS7QW+jVyld7MPC/jqKNZx
        x7HGkEckRJMtZ/dYfNQpby9t8fgA
X-Google-Smtp-Source: ABdhPJxU7+gwtOC9ELOgpSVg8A7Lmnf9G5OvHirrIuFP+b9JZyDB5dcOaqyb4koUUibEjU9Ns9Z4dQ==
X-Received: by 2002:a17:907:11db:: with SMTP id va27mr56477734ejb.175.1594251722301;
        Wed, 08 Jul 2020 16:42:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:01 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] sparc: char are unsigned on Solaris
Date:   Thu,  9 Jul 2020 01:41:48 +0200
Message-Id: <20200708234151.57845-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Solaris, at least on sparc32, chars are unsigned.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-sparc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target-sparc.c b/target-sparc.c
index bd48effe3acf..865dbc8a2180 100644
--- a/target-sparc.c
+++ b/target-sparc.c
@@ -19,6 +19,8 @@ static void init_sparc32(const struct target *target)
 
 		bits_in_longdouble = 128;
 		max_fp_alignment = 16;
+
+		funsigned_char = 0;
 	}
 }
 
-- 
2.27.0

