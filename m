From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Sun, 19 Mar 2017 16:36:10 +0100
Message-ID: <20170319153609.yykbjbbb6v4lw4xb@macpro.local>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35018 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdCSPgn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:36:43 -0400
Received: by mail-wr0-f175.google.com with SMTP id g10so78258854wrg.2
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:36:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 13, 2017 at 10:54:01PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> I am investigating a type error in LLVM. Here is the snippet of code:

This seems to be fixed in the llvm-fixes-v3 serie I submitted yesterday.
But I never saw exactly what was the specific problem here.

-- Luc
