From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Reverting OP_SYMADDR in sparse-llvm
Date: Tue, 21 Mar 2017 10:59:47 +0000
Message-ID: <CACXZuxdwK2QJzPOfP-QaLiWa5ow9oRHPA7=EpMEzkin6FrsfiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36551 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756171AbdCULHF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 07:07:05 -0400
Received: by mail-io0-f171.google.com with SMTP id l7so46117078ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 04:07:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

In the last two sets of patches I have noticed that you have reverted
the change related to OP_SYMADDR. I would like to understand what fix
in sparse-llvm made this change unnecessary.

Thanks and Regards
Dibyendu
