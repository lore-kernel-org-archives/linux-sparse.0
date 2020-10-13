Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650BEC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE7E206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkDp9qV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgJNJYo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgJNJUC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:02 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE8C05BD36
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x1so1231188eds.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSOu6druYwrZdezBwPdOFzMhfp9CpJaaYObSrjMj+Sc=;
        b=FkDp9qV2d1b+tR6YFzjR0fj6jYUXWgzjopIj2jQxqUeHwZTY00+qBP2UXkrhbmTe5O
         R/lOCoTH+wZCOntOkzE9BqqkeQfb7PVEhDjqC2objfZLetYnYu69G4pjvBNKiWcOZmzZ
         Zdy8YTvLbb96v9USOLLbeoLPTlKh2ijn5Cp1zpwHoHcdVJ3WVOwJnopFtwS+hGhG0CWw
         TncxtL3v9WaRy3GMm2VCpXNGH3iy5uZ4A3eJvIs+0b6olYJ+Q+lkXqF6KtKjasyhEmcM
         Qh1e8bu5/QeBuWsYVzDVNSY97E8Z6JwbsMRbb5hbo6RTIjt0g40eGDrD6GKhmZEaaDw6
         h89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSOu6druYwrZdezBwPdOFzMhfp9CpJaaYObSrjMj+Sc=;
        b=f/5jH4KFMFnPDF/ectpjCdshT1xNREPGYkq1hx36nvM3yj8NjesrMIVc9N078jHe8F
         IeUwJ8nN2v60Y9hulPtz+4dQJv+5PgBrky2b01yzFmE5j+a62JMG/GDYcKPFArjLM1Vf
         uyye9n+QCtzSmi2VyaxJrj0flTrjiYrL39s+qQdaOkPNWfeZZESrFz6b++tlcCwsIAGQ
         hfmztrzsQt5kF/UpAp6kdsrSUP8flOgtOnWnMdxX4eRFOPN3m/f019Ff9OgBQxG5nccb
         0pk9Esfh0wmz2NZoL7k7Nb1R44URhKeE2Y5ZoJCy0afFPoj2dyoiNfsXxMEu4568+uFe
         dqlw==
X-Gm-Message-State: AOAM530Y59VMSbUy1qcqfDEs2gSetjJzY+VCgXQZl3ty+bl9zEP8/kKo
        AJeW8UoHx9q3lIpnmcuuSeQRsiV/95Q=
X-Google-Smtp-Source: ABdhPJwg7JpvHtD8oTtvFFZCe83jcpYtTA6XNU0BoV6ky4+Y3aqqW1+aje3YOHUd7xvrrbr07ZtAQA==
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr2206293edb.197.1602631360343;
        Tue, 13 Oct 2020 16:22:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/13] format-check: add specific type checking
Date:   Wed, 14 Oct 2020 01:22:18 +0200
Message-Id: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These patches improve/complete the parsing of the lenght and
the type modifiers and, more importantly, add specific checking
functions for all the types, replacing the use of
check_assignment_types() which don't do the kind of type checking
needed here (and which evaluate expressions, something not
needed and which complicate the interface a lot).

These checking functions are not yet complete but are a solid
base for some further improvements. They already allow to
use 'sparse -Wformat' on the kernel without false positive
and can detect of a few errors.

The series is available for review & testing at:
  git://github.com/lucvoo/sparse-dev.git format-check


Luc Van Oostenryck (13):
  format-check: void * is not OK for strings, fix the test
  format-check: more complete parsing of the length & type modifiers
  format-check: add helper type_class()
  format-check: merge 'fmt_string' & 'string'
  format-check: remove unneeded member: target
  format-check: add a function to check to type of strings
  format-check: add a function to check to type of 'n' arguments
  format-check: add a function to check to type of pointers
  format-check: remove printf_fmt_print_pointer()
  format-check: add a function to check the type of floats
  format-check: add a function to check the type of integers
  format-check: remove wrappers around type checking methods
  format-check: simplify calling of parse_printf_get_fmt()

 validation/varargs-format-addrspace1.c |  12 +-
 verify-format.c                        | 496 ++++++++++++++++---------
 2 files changed, 323 insertions(+), 185 deletions(-)

-- 
2.28.0

