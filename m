From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Adding an option to sparse to disable the IR simplifications
Date: Wed, 22 Mar 2017 19:56:16 +0000
Message-ID: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37632 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdCVT4S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 15:56:18 -0400
Received: by mail-it0-f51.google.com with SMTP id 190so29579710itm.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 12:56:17 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

With the progress made with spars-llvm in recent weeks we are now
beginning to hit bugs in the simplifications carried out by the
linearizer. So it is useful I think to have an ability to turn off
these modifications - perhaps by a command line argument. This will
enable testing of sparse-llvm with and without the simplifications,
and help identify issues caused by the latter phase.

Thanks and Regards
Dibyendu
