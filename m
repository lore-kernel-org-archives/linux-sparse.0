From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Tue, 7 Mar 2017 07:44:37 +0100
Message-ID: <20170307064436.qtcscbwbjsrjoyko@macpro.local>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37553 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdCGHmg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 02:42:36 -0500
Received: by mail-wm0-f52.google.com with SMTP id n11so83417883wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 23:42:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 07, 2017 at 12:08:22AM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> When I try to compile following in sparse-llvm:
> 
> int main(const char *argv[]) {
>  int values[5];
>  values[0] = 9;
>  ...
>  values[4] = 5;
>  int *p = &values[4];
>  return (*p == 5) ? 0 : 1;
> }
> 
> I get:
> 
> @values = external global [5 x i32]
> ...
> 
> Here 'values' has been defined above as external global, whereas it
> should be allocated on the stack.

Mmmh, I'll need to look a bit further at this one.

Thanks, for the report.
 
-- Luc
