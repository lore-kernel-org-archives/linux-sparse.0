From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 23:44:16 +0100
Message-ID: <CACXZuxcOP5q8y+P5H9Xe4-KFbrLcHN4OcxVOr4-n2yj-3RHuqg@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com> <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35419 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdHOWoS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 18:44:18 -0400
Received: by mail-ua0-f172.google.com with SMTP id d29so8056527uai.2
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 15:44:17 -0700 (PDT)
In-Reply-To: <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I think it would be good to perform a detailed comparison / assessment
of where the problem lies currently versus the new solution. I get the
impression that the current problem is not well explained or
understood.

Here are two known issues at present. You can see the old linearized
output and the new linearized output - both produced with
simplifications switched off.

C code:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug.c

Old linearized output:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug_old.lin

New linearized output:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/bugs/simplifybug_new.lin


C code:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/set1/onebit.c

Old linearized output:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/set1/onebit_old.lin

New linearized output:
https://github.com/dibyendumajumdar/dmr_c/blob/newssa/tests/set1/onebit_new.lin


The two situations where I see problems currently are exemplified
above. In the first case the outputs are clearly different - and here
the issue appears to be how undefined pseudos are handled. In the
second case, the original linear output seems identical to the new
output - so the issue probably lies in the single store shortcut.

Regards
Dibyendu
