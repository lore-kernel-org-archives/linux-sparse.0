From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: New backend for Sparse
Date: Tue, 4 Jul 2017 23:11:04 +0100
Message-ID: <CACXZuxetCi8s1KSvttt6KeuwRgnQNenBPexVd3gyUhrzCiN2qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38377 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdGDWLG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Jul 2017 18:11:06 -0400
Received: by mail-wm0-f48.google.com with SMTP id f67so95648203wmh.1
        for <linux-sparse@vger.kernel.org>; Tue, 04 Jul 2017 15:11:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

For the past few months I have been working (sporadically) on a new
backend for Sparse. This backend utilizes a JIT library originally
created at Adobe, then used and subsequently abandoned by Mozilla. It
is known as NanoJIT. The NanoJIT library is small compared to LLVM and
lacks the latter's optimization capabilities. Also there are some
limitations in the library that prevent some features of the C
language from being supported. The main advantage for me is that it
has been relatively easy to implement the backend - the NanoJIT IR is
similar to Sparse IR in that it works at a low level - and does not
understand aggregate types. Hence in some ways it is a better fit for
Sparse than LLVM.

I wanted to share following which gives you some idea of the progress
made thus far:

https://github.com/dibyendumajumdar/dmr_c/tree/master/tests/nano

Eventually I think I would like to write my own backend from scratch
... but that is perhaps some way away.

Thanks and Regards
Dibyendu
