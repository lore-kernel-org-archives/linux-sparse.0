From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] simplify types for struct access_data
Date: Wed, 14 Feb 2018 02:51:40 +0100
Message-ID: <20180214015142.24725-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36985 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966425AbeBNBvt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id v71so19254934wmv.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:51:48 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These two patches somehow simplify the use of type by 
'struct access_data'.

Luc Van Oostenryck (2):
  let struct access_data use a single type
  rename base_type() to bitfield_base_type()

 linearize.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

-- 
2.16.0

