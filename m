From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/16] testsuite improvements
Date: Sat, 9 Dec 2017 10:09:05 +0800
Message-ID: <CANeU7QnkVby=2P+q5xt8KSKaceFZx+1+m1SVp=vfDEZ2pkymbQ@mail.gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:43277 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdLICJG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 21:09:06 -0500
Received: by mail-yw0-f182.google.com with SMTP id n25so5010846ywh.10
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 18:09:06 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Dec 8, 2017 at 9:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains a few fixes & improvements to the
> testsuite; mainly:
> - allow to run the testsuite on all the tests of a subdir
> - teach 'format' to directly append to the testcase
> - validate the 'check-...' tags
>
> Luc Van Oostenryck (16):
>   testsuite: make the '%.t' rule depends on PROGRAMS too
>   testsuite: fix a few more incorrect check-commands
>   testsuite: convert to the new pattern syntax
>   testsuite: remove old ugly pattern syntax
>   testsuite: move verbose/error() before get_tag_value()
>   testsuite: add & use warning()
>   testsuite: reset 'quiet' at the start of each testcase
>   testsuite: fix invalid 'check-...' tags
>   testsuite: validate the 'check-...' tags
>   testsuite: early return in getopt loop
>   testsuite: move do_test_suite out of the getopt loop
>   testsuite: move no-arg out of the getopt loop
>   testsuite: change do_usage text
>   testsuite: allow to test only a subdir
>   testsuite: default to shift in the getopt loop
>   testsuite: add support for 'format -a'

I haven't have a chance to do the full review as I did before
applying them. I just briefly go over the patches. From the
distance I look, the series looks fine for me.

Usually as long as the make check was not broken,
I am not too worry about the testsuite changes.

Chris
