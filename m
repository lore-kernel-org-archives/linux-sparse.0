From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/5] testsuite: report as error tests known to fail but
 which succeed
Date: Fri, 18 Nov 2016 13:52:51 +0100
Message-ID: <20161118125251.GA17412@macpro.local>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
 <20161102214509.36571-4-luc.vanoostenryck@gmail.com>
 <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36000 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbcKRMw4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Nov 2016 07:52:56 -0500
Received: by mail-qk0-f196.google.com with SMTP id h201so31801448qke.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2016 04:52:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 18, 2016 at 12:13:58AM +0800, Christopher Li wrote:
> On Thu, Nov 3, 2016 at 5:45 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Such situation may simply show that what was tested is now fixed
> > and that it's juste the test annotation which need to be adapted,
> > but can be a sign that something else is broken.
> >
> > Reporting the exact result (failure/success, known-to-fail/expect-to-succeed)
> > make the testsuite more useful and allow to use more efficiently
> > git-bisect or other automated testing tools.
> 
> I like what you are doing as a result.
> 
> But I think the implementation has room to improve.
> I don't like deep and messy "else" statement.
> 
> I attach a patch which I modify base on yours. I hope it is
> easier to read. Care to review it?

Yes, I much prefer like this. Thanks.

But there is something I would like to check but I can't do that now.
I'll come back on it later.

Luc
