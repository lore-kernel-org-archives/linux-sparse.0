From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] add support for __int128
Date: Sat, 10 Dec 2016 00:03:09 +0100
Message-ID: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36254 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbcLIXDV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Dec 2016 18:03:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so61779wma.3
        for <linux-sparse@vger.kernel.org>; Fri, 09 Dec 2016 15:03:21 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add support for this type since there is a proposal to use it
in the Linux kernel.

The first patch first fix a bug related to long long long int,
the second one really add the support.

Luc Van Oostenryck (2):
  fix missing element in types declaration
  add support for __int128

 parse.c             | 12 ++++++++++-
 validation/int128.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 validation/int128.c

-- 
2.10.2

