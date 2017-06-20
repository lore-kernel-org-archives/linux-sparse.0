From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] teach sparse about endianness
Date: Tue, 20 Jun 2017 22:19:28 +0200
Message-ID: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36584 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFTUTh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 16:19:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id x81so17264077lfb.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 13:19:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to let sparse correctly
check macros, structures, ... endian-specific.
This is done by:
1) the introduction of a pair of option flags:
   -mbig-endian/-mlittle-endian 
2) a set of predefined macros:
   __{BIG,LITTLE}_ENDIAN__,
   __ORDER_{BIG,LITTLE}_ENDIAN__ &
   __BYTE_ORDER__
