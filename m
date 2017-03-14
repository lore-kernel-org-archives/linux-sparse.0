From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm when generating code for op_muls, op_divs first argument
 may be a pointer
Date: Tue, 14 Mar 2017 13:14:20 +0000
Message-ID: <CACXZuxekhPX=9UGiBkboZ2viBpY4gftUC4v9xuCmOKvsU7QoHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36093 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdCNNOW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 09:14:22 -0400
Received: by mail-io0-f179.google.com with SMTP id l7so103777538ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 06:14:21 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Sparse-llvm currently generates incorrect code for op_muls and op_divs
when the first argument is a pointer. In this case the pointer should
be converted to integer before multiplying or dividing.

Thanks and Regards
Dibyendu
