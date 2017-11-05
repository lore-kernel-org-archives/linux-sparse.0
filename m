From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: multiarch & base dir
Date: Sun, 5 Nov 2017 10:33:02 +0100
Message-ID: <20171105093301.adsucwshznehtdr4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52647 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbdKEJdG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 04:33:06 -0500
Received: by mail-wm0-f43.google.com with SMTP id t139so8771847wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 01:33:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

Hi,

Commit 85e2e2a25 "Add support for multiarch system header files"
added for GCC's multiarch directory. One of the change was :
+       /* add the multiarch include directories, if any */
+       if (multiarch_dir && *multiarch_dir) {
+               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
+               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
+       }


There, the multiarch dir is appended to /usr/include & /usr/local/include.
I'm wondering if using GCC_BASE should be used here instead.
Any thoughts?


Best regards,
-- Luc
