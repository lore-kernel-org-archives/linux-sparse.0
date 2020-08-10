Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411CC433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919A0206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IESyHTSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHJVym (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVyl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED645C061756
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so7519092edk.6
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owoFqRSLHPC6QBtMQQV+86rvdmE+23ptOkGxeNSsUp0=;
        b=IESyHTSEYTYHXV+BAzvqSlrJFGd7DT3wrCi5DbuoEC8EXpO6/taewMJyzp7YHDj+mg
         7RSmemp1BwqeAJ7U8GluXGqTstSUxTuByALc4CfrF4tD9M/ti6IR83oaKw0w5+p/0bZ0
         dwKMwsiGbc6t6I2g+WlsCXm5MUEyc1UAnHgQ19u52Nfu++mzUFMZo9XQxSpnXU/xbdGK
         oc5G1txgeQ5bCy9UpYj2e9UXkehXKv1UkVWFokQU9TeA4ZHFiPt8EaZYoQOoVjvKIbMo
         m7Nl1VdjTSKDP7mQbmbZDgUEppxqf0sKCmoWS0RzUWI7BQbJuDmfFVC86yPNG1RC6m9P
         MIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owoFqRSLHPC6QBtMQQV+86rvdmE+23ptOkGxeNSsUp0=;
        b=GLnka0R1JISO/qSX2EZTrSpeJT85AVcOVn6uh3UGmukpYTTNTEMMA2XWh44P8L+/TH
         1F2OtPX/mejayF8vZXahTfg02Z90VslbJwGW0sg/3kZGIiJ+IW88FsBv4EnduysF1EL2
         gxKeapfYnmdoCAxXrYjsFyFMRPMdsYX4aCPjtgGH4rtQQYBz8No3wCJsy8TUCIHbi2Mx
         Ao6rNbjTFjf3mosqLaexVtZQ2Wkq4M4HQcXyD+1Os6PTLefq4Wswy7Al5ELx/94oZMxE
         YdNsjyflGPOzI5uobt/YHU8JP4kzWAgKnzV/2BKA9QqZb8heCZp6QXnjFXlIyuLl+MDY
         2LTg==
X-Gm-Message-State: AOAM530RU4NKh1k+su9bbA0NWh1OtkX2vYEiSr4zsbHCx3Gyy7wW9sQS
        +ohkoKRYdrnoltRFquYELvonzhNI
X-Google-Smtp-Source: ABdhPJzkCt+lmMANrlXNUc4D3B8PMMBpKmPeFPSFGo4la+sAS+nYEYDwQrm58l6okHyAPKjTI4o8RQ==
X-Received: by 2002:aa7:cf19:: with SMTP id a25mr22335717edy.67.1597096479428;
        Mon, 10 Aug 2020 14:54:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/7] doc: small tweaks to the online documentation
Date:   Mon, 10 Aug 2020 23:53:29 +0200
Message-Id: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains some adjustment to the spacing in the generated
HTML and some small changes in the content of the main page.

Luc Van Oostenryck (7):
  doc: use a smaller logo in the sidebar
  doc: make the sidebar more compact
  doc: decrease vertical spacing
  doc: move down info about tarballs, after git repositories
  doc: reorganize the table of content
  doc: use shorter titles
  doc: add links to some external doc

 Documentation/IR.rst                          |  4 +--
 Documentation/conf.py                         |  8 +++++-
 Documentation/dev-options.rst                 |  4 +--
 Documentation/doc-guide.rst                   |  4 +--
 Documentation/index.rst                       | 26 +++++++++++--------
 .../sphinx/static/theme_overrides.css         | 20 ++++++++++++++
 Documentation/types.rst                       |  6 ++---
 7 files changed, 51 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/sphinx/static/theme_overrides.css


base-commit: 6fe6d05b56815966b452b0363c9ffd11e1787f85
-- 
2.28.0

