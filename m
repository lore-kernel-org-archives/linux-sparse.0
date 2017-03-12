From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm op_fpcast implementation missing
Date: Sun, 12 Mar 2017 01:01:27 +0100
Message-ID: <20170312000126.zhnamtidjwdycvkg@macbook.local>
References: <CACXZuxdZDSYP2j-8BJ6X_F9qpYWtdcVqZny06G_Qe0dkv_pOpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36680 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbdCLABb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 19:01:31 -0500
Received: by mail-wr0-f178.google.com with SMTP id u108so84058881wrb.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 16:01:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdZDSYP2j-8BJ6X_F9qpYWtdcVqZny06G_Qe0dkv_pOpw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Mar 11, 2017 at 11:53:53PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> Following test fails:
> 
> int main(void)
> {
>  float f = 'a';
>  float g = 97;
>  printf("%f %f\n", f, g);
>  return 0;
> }

Just for info, there is a lot of things missing or incorrect with
floating-points and I'm not speaking of the llvm part but of
sparse itself.

I have some test cases somewhere in one of my topic branches
but this is very very low priority to me.

-- Luc
