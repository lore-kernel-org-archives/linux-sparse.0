From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm should handle pointer arithmetic in op_sub similarly to op_add
Date: Tue, 14 Mar 2017 13:15:37 +0000
Message-ID: <CACXZuxdSjyC6iiqgj7tJ8AnKi4iBpsM484BEw_4HoepSOUViBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37124 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdCNNPj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 09:15:39 -0400
Received: by mail-it0-f44.google.com with SMTP id g138so50951390itb.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 06:15:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

It appears that the linearised code may have op_sub instructions for
pointer arithmetic. This needs to be handled similarly to op_add.

Regards
Dibyendu
