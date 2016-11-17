From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/5] testsuite: simplify the ioc-typecheck case
Date: Fri, 18 Nov 2016 00:17:58 +0800
Message-ID: <CANeU7QkK5p8bt=qBAjC+TnUZxE=Ek_rkaZrc41wJnRpcGkOV4Q@mail.gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com> <20161102214509.36571-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38779 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcKQRNg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:13:36 -0500
Received: by mail-it0-f41.google.com with SMTP id j191so63544570ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:13:36 -0800 (PST)
In-Reply-To: <20161102214509.36571-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>

On Thu, Nov 3, 2016 at 5:45 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The test was relatively convoluted and it wasn't very clear what
> was the problem and waht was tested.
>
> The real problem is simply a problem about a non-constant
> expression in an array designator.
>
> Simplify the test to clearly show that.

Applied.

Chris
