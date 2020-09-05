Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB79C43461
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC03620757
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3k7NJUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgIEMOM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgIEMOL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 08:14:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0467EC061244
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 05:14:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so8470029edk.6
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrueyCSjMVn75NMc2WLc6Ij/toDuzvTrUhUOg6CPg8E=;
        b=J3k7NJUN8ArPVZxxBVyFB8tCDoFYuzTfpZVtgTUwir5TIemGB4xInnURMs6hNlDTJZ
         8yIQqfMxGjqDLCj1VaixuWY2uQPaXz3RjHATyFP1qMDr16UAXrnOPnB80P+z12if3ivQ
         14RT/HbgvkStynEJl9hKu7jQzJ2j25sEIqZiOyfB909dSXaftEddZ6nkaj4bANDxt233
         udm9jthHsBq32kBEQbabi3rVOpt3dAeOyZmwl4ISiZMywrtH08+JPIUcEIYufSEQY4Fl
         IWMjXTV2biKrbXJv0r+Wo1EuYbkscYOeQxGgN8r+uTXttITTUpeeeR6ktGd+qduYg6Ad
         OdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrueyCSjMVn75NMc2WLc6Ij/toDuzvTrUhUOg6CPg8E=;
        b=Ro8Phes15KWWL1eGlj+VUfOGbA8cPt4AE8Wao2bdZAKjvU1ejBlYcDNGdwUTe/FO1a
         Ifj31VAIJffpRaiaJHjKkWQR5tlRI17+yvB6DFVDmyInA15+7kgXCKUUwwRpk6BKlcSQ
         aC16JYibmU6g9Ba3YyOFM/6NZtXFOTlA4EOrtMrkNexkypFG7LiE8uibHcGKwe3TVLJT
         2y0ObRe29IO9dKIEnPwiQXWpqJmhdO3SJr+8VjdiLiHtgl/EpR+DmXwcb/8Z9G70052U
         f0KaeB13KWw4b+7RijMEBp7/XT1I11vgsPL52bUa6M4sv1NlCF/ekGz0YoNK+2WNwqtY
         ElfQ==
X-Gm-Message-State: AOAM532DmCzv+UI3XdOqf4UOGKxJRl18rvV8IO2NBgFYMtFsbtWvWVCK
        /mqKefg8qqAVdekU5oNTooUZUqsh7XE=
X-Google-Smtp-Source: ABdhPJzIE6kiFMJrVdpofSUJNDo8D52vTaZk2mhh1S6T/gHj7LC21N5ehqDZ4Tn/IABBiUxiuBuFxQ==
X-Received: by 2002:a50:d809:: with SMTP id o9mr12980711edj.12.1599308042331;
        Sat, 05 Sep 2020 05:14:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id k14sm8577412edo.89.2020.09.05.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 05:14:01 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] add and use new helper: replace_with_value()
Date:   Sat,  5 Sep 2020 14:13:55 +0200
Message-Id: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This makes things slightly more readable and is a preparatory
step for some others series.

Luc Van Oostenryck (3):
  add helper replace_with_value()
  use replace_with_value()
  replace_with_{pseudo,value}() can be tail-calls

 simplify.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.28.0

