From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm subtraction of one pointer from another should
 result in int difference
Date: Sun, 19 Mar 2017 16:37:42 +0100
Message-ID: <20170319153742.5zuijqckyw67tyks@macpro.local>
References: <CACXZuxdaVMn8gHkUWWp6opkB0CJ7WAVmEt2P_yqtT9WUO_-LVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34317 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdCSPib (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:38:31 -0400
Received: by mail-wm0-f53.google.com with SMTP id 196so14877193wmm.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:37:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdaVMn8gHkUWWp6opkB0CJ7WAVmEt2P_yqtT9WUO_-LVQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 13, 2017 at 08:59:02PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> I was investigating an error reported while compiling minilua (please
> see my earlier post on minlua) and I found that one of the issues was
> that the result of subtracting one pointer from another is not handled
> correctly in sparse-llvm.

This is fixed in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc
