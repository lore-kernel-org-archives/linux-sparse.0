From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is disabled
Date: Tue, 30 Sep 2014 11:26:11 +0800
Message-ID: <CANeU7Q=vDAuBwWqy0=rbvkpgmzysCw=pfSEcwzyRRSZj3QrJbA@mail.gmail.com>
References: <53DFD320.2050903@ramsay1.demon.co.uk>
	<CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>
	<5426BD97.2080700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35412 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaI3D0M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Sep 2014 23:26:12 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so5718218ykq.38
        for <linux-sparse@vger.kernel.org>; Mon, 29 Sep 2014 20:26:11 -0700 (PDT)
In-Reply-To: <5426BD97.2080700@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Sep 27, 2014 at 9:37 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> On 27/09/14 05:29, Christopher Li wrote:
>
> Unfortunately, sparcec and sparsei are the commands that are
> used by the tests (I included sparse-llvm in the list in case
> any _future_ tests used it directly), and they do exist and
> are executable. They simply will not work if sparse-llvm is
> not built.
>

I see. That make sense.

We just need a way to specify the dependency of test commands.
e.g. sparsec depends on sparse-llvm. So if sparsec does  not exist,
or sparse-llvm does  not exist, the test will be skipped.

I am thinking some thing in the test-suite like:

set_deps sparsec sparse-llvm
set_deps sparsei sparse-llvm

...
get_deps `basename cmd`
dep_cmd=$last_result

> Note that I renamed sparse{c,i} to sparse{c,i}-in. It may have been
> better to name then sparse{c,i}.sh, since they are not really templates
> to be 'processed' to create a build product. dunno.
>

I prefer specify the dependency. Another copy is not necessary.

Chris
