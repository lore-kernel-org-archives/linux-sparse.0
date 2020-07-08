Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB37C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC9620708
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etyDlpZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgGHVzf (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHVzf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:55:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C57C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:55:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so54870eja.9
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r04Ow6HKiG907E7GT9VcwQJhLGmQMl2zd+cpwCIE0+o=;
        b=etyDlpZqbH3QtbFABruulJjYENBVFNBDq1f0YMI9AzHkUl7Oe/Ko6XOuQiVx2AcylR
         A7i5cFxHo+8mH9HBMOZJhRNYEkNwy+SKxE/cjRRc64vaR3fCyXFXEf9YY7o3Cp/Dy5gc
         5IDrf4di2SHCxUdOfqVv0RrmakGpSpLj5hTPU4uQcZcOiezJMcGSzHKJed7BM4TXqhpD
         JcxEBxKmcPTnBQdpw4tiqvGE8vaEb4lHxpGBVMLjYOUmb69GQLRVL3AF+ImNMMYAyM0F
         Klhj6VXW596N8CC/fWbxjotGyZwWCGrh2aCAiFoTb3E6STlMJYAmX7xqnzqi8PKsJYll
         jGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r04Ow6HKiG907E7GT9VcwQJhLGmQMl2zd+cpwCIE0+o=;
        b=nG69Q3xybz1IKlGWGQ5zo5aS3wvF0hR8XkF1IpbkHACoF+CpphyCEK8jeq1uvolEGd
         LtAy+E+8Q43n4MOluIbYuVl3vhDTpHPpov4/qQGkazNHsIxEJY/imaDl21G3srzMag6A
         kn6PFsewKb6AIyI06xF0N0GA0O8NbfZnJbgxQ/9N08hPpeAHrN+aGXRy8yGqDiIQj7PE
         FQ82+3BqLJCfCg1eek50PmglmrXI7UjNLnqvitsCRkuidAVpb8FKmy37lyol2IAWLWah
         C5Vg0HJwHSMOKeZNl+huAva3SqDai5NOvJsYmH4tzJ6ZR2cqKyYwj7i/8J58fjACrHhl
         /d5A==
X-Gm-Message-State: AOAM533I/1v64uTWSYG/t3qh6DDiq6SAJvxSfGNmw20tfEJdJc/cbNNd
        /ptJvIcO3FWCq69co2bdo+A8lB0F
X-Google-Smtp-Source: ABdhPJzyDTE1B44aUEXMlb0Bo40zp1aSZXhF6GVS29d8H9dJCMLej3wdhKUTq0r7n1lK218ZhwGlmw==
X-Received: by 2002:a17:906:1998:: with SMTP id g24mr50830336ejd.11.1594245333367;
        Wed, 08 Jul 2020 14:55:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id a8sm478999ejp.51.2020.07.08.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:55:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] add the predefines for endianness
Date:   Wed,  8 Jul 2020 23:53:26 +0200
Message-Id: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series adds the missing predefines for testing the
endinaness on ARM, ARM64 & MIPS.

Luc Van Oostenryck (3):
  mips: add predefines __MIPSEL__ or __MIPSEB__ & friends
  arm64: add predefine for endianness
  arm: add predefine __ARMEL__ or __ARMEB__

 target-arm.c   |  5 +++++
 target-arm64.c |  5 +++++
 target-mips.c  | 10 ++++++++++
 3 files changed, 20 insertions(+)

-- 
2.27.0

