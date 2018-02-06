From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix usage in converted loads
Date: Tue,  6 Feb 2018 20:41:41 +0100
Message-ID: <20180206194143.1285-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46275 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeBFTnw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Feb 2018 14:43:52 -0500
Received: by mail-wr0-f195.google.com with SMTP id 35so3199181wrb.13
        for <linux-sparse@vger.kernel.org>; Tue, 06 Feb 2018 11:43:52 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This patch contains a fix for the usage of the address pseudo
not being adjusted after conversion.


Luc Van Oostenryck (2):
  add testcase converted loads
  fix killing of converted loads

 flow.c                            |  1 +
 validation/optim/load-converted.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 validation/optim/load-converted.c

-- 
2.16.0

