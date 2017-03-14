From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm op_shl and op_lshr code generation issue
Date: Tue, 14 Mar 2017 14:04:02 +0000
Message-ID: <CACXZuxd8cqkqDPbUULWx1VibiZsWi_pEULiBejKPR56KENRh=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:35761 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdCNOEE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 10:04:04 -0400
Received: by mail-it0-f52.google.com with SMTP id m27so47653037iti.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 07:04:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

If the rhs is not of the same size as the lhs then LLVM rejects the
code. A fix is to extend the rhs to match the lhs.

Regards
Dibyendu
