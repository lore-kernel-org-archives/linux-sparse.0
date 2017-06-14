From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Understanding how sparse handles multiple input files
Date: Wed, 14 Jun 2017 22:25:59 +0100
Message-ID: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32778 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdFNV0B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Jun 2017 17:26:01 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so15917131wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 14 Jun 2017 14:26:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to understand what happens when multiple input files are
given to sparse. Are the symbols from previous files dropped when
sparse moves on to the next file?

I see a call to remove_symbol_scope() in end_scope() implying that
symbols are dropped - but then I am not sure I am understanding this
correctly.

Thanks and Regards
Dibyendu
