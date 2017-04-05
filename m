From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] restricted pointers
Date: Wed,  5 Apr 2017 23:09:18 +0200
Message-ID: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34301 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933224AbdDEVJk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so6043072wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add minimal support for C99's
'restrict' type qualifier.
As preparatory steps this series also contains:
- a cleanup of the #define MOD_...
- a change on how errors inhibit warnings
and as bonus it also contains:
- support for '_Atomic' type *qualifier*


This series is available at:
	git://github.com/lucvoo/sparse.git restricted-pointers
based on commit:
	14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
up to commit:
	d109442871cfd2065ae7d3440981ab800054f241


Luc Van Oostenryck (9):
  remove never-used MOD_TYPEDEF
  avoid warnings about using 0 instead of NULL
  finer control over error vs. warnings
  MOD_ACCESSED is not a type modifier ...
  reorganize the definition of the modifiers
  MOD_STORAGE redundancy
  MOD_QUALIFIER
  associate MOD_RESTRICT with restrict-qualified variables
  add support for C11's _Atomic as type qualifier


-- Luc Van Oostenryck
