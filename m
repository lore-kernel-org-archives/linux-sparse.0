From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Another potential issue with linearized output
Date: Tue, 21 Mar 2017 21:41:01 +0000
Message-ID: <CACXZuxfdKn-x_-nVbLy4PGMpmVDk-_7RESOQcfPT8FLa7JDEzQ@mail.gmail.com>
References: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36643 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758276AbdCUVlW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 17:41:22 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so56361339ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 14:41:03 -0700 (PDT)
In-Reply-To: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 21 March 2017 at 15:54, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> When I try to compile following test (see link) in sparse-llvm - LLVM says:
>
> Instruction does not dominate all uses!
>   %load_target = load i32, i32* %191
>   %R122 = icmp eq i32 %load_target4, %load_target
> Instruction does not dominate all uses!
>   %load_target = load i32, i32* %191
>   %R283 = icmp eq i32 %load_target4, %load_target
> Instruction does not dominate all uses!
>   %load_target = load i32, i32* %191
>   %R522 = icmp eq i32 %load_target4, %load_target
>
> I have not yet investigated what the issue is but I thought it best to
> post the test case so that it can be validated.
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/cq3.c
>

Appears that the problem is occurring in simplify_one_symbol().

Regards
