From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect definition of global string constants
Date: Thu, 16 Mar 2017 22:29:56 +0000
Message-ID: <CACXZuxde24jH_Aa9Hw2Go3HmQeEv6qaHGOba9w_gGcY_u5Wbnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:37001 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbdCPWhU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 18:37:20 -0400
Received: by mail-it0-f42.google.com with SMTP id g138so6036372itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 15:37:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

It appears that multiple global string constants are defined, they all
end up pointing to the first constant. This is because sparse-llvm
looks up the name of the symbol - but this is always '<noident>' as
the symbol lacks a name. The fix is to avoid looking up the global if
there is no name.

Regards
Dibyendu
