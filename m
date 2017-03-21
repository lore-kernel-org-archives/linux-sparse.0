From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v4 00/63] LLVM fixes
Date: Tue, 21 Mar 2017 11:24:57 +0000
Message-ID: <CACXZuxdcgnhBwnaS9nDqh47KrpkqEu11SB6FXGTebpBPZ1GZ-A@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36170 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756609AbdCULZx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 07:25:53 -0400
Received: by mail-io0-f181.google.com with SMTP id l7so46334471ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 04:24:58 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Luc,

On 21 March 2017 at 00:15, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series solves a number of issues in sparse-llvm,
> mainly about wrong or missing type information as needed
> to build LLVM IR.
>
>
>   llvm: add test cases for symbol's address
>   llvm: add test cases for pointers passed as argument
>   llvm: add test cases for arrays passed as argument
>   llvm: add test cases for degenerated pointers
>   llvm: add support for OP_NEG
>   llvm: add support for OP_SETVAL with floats
>   llvm: add support for OP_SETVAL with labels

Thank you once again for posting this set of patches. I wanted to
understand what your approach is with testing of the LLVM backend in
general. The test cases that are currently present and also the new
ones you are adding do not appear to be runnable. Unless you are
saving expected LLVM IR output and comparing the test output with that
I think the tests do not prove that the generated code is correct.

Thanks and Regards
Dibyendu
