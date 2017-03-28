From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 21:41:09 +0100
Message-ID: <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38283 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdC1UlV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 16:41:21 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so34728057itc.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 13:41:15 -0700 (PDT)
In-Reply-To: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 28 March 2017 at 21:25, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am investigating an issue with following test case:
>
> int main(void)
> {
> const char *names[] = {
> "dibyendu",
> "majumdar",
> NULL,
> };
> return 0;
> }
>
> The issue here is that sparse-llvm thinks the array size is zero:
>
> define i32 @main() {
> L0:
>   %names_0000026DE9D2DDA8. = alloca [0 x i8*]
>
> It appears that sparse is correctly calculating the size of the array
> in examine_node_type() in symbol.c, but by the time the symbol gets to
> sparse-llvm the bit_size is somehow changed to -1. I haven't yet
> tracked down where this is happening.
>

Looks like the computed bit_size is being held on the SYM_NODE but
sparse-llvm looks as the bit_size field in the SYM_ARRAY node. Does
this sound like a problem - i.e. somehow the SYM_ARRAY is not getting
its size set?

Regards
Dibyendu
