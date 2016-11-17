From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix type checking of variadic functions
Date: Thu, 17 Nov 2016 08:06:41 +0800
Message-ID: <CANeU7Qm0WbqFA1H6w7U=KmeLc90tyJdfsfQFqC4H_-c4mMQ1Hw@mail.gmail.com>
References: <20161102171349.17666-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33965 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbcKQAGm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Nov 2016 19:06:42 -0500
Received: by mail-it0-f67.google.com with SMTP id o1so10935762ito.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Nov 2016 16:06:42 -0800 (PST)
In-Reply-To: <20161102171349.17666-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Nov 3, 2016 at 1:13 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When doing a type comparison between functions, in the varidicity part,
> the base type of these functions (= their return type) is
> wrongly used intead of their own type.
>
> Fix this and add some tests showing this and others cases are
> now OK

This looks correct to me. The function return type can't be a function.
So the base type of the functions will never have the variadic bit set.

Speaking of the test case, there are two case can be added:

void arg_incomplete();
void arg_incomplete(int a) {} /* check-should-pass */

void arg_incomplete_vararg();
void arg_incomplete_vararg(int a, ...) {} /* check-should-fail */

Sparse handle the first one incorrectly. But that is a separate issue,
we can address it in a different patch.

Will apply.

Chris
