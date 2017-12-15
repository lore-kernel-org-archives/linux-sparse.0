From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/6] whitespace & '-D' option
Date: Fri, 15 Dec 2017 14:15:17 +0800
Message-ID: <CANeU7Qkas1L8YkVorGbbH_cH_Azm_KEErrGv0LQJ9GcH_0fbvg@mail.gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:32909 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdLOGPS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Dec 2017 01:15:18 -0500
Received: by mail-yb0-f171.google.com with SMTP id b15so1716956ybn.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 Dec 2017 22:15:17 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 14, 2017 at 1:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains two fixes concerning the '-D' option
> and white spaces. A a bonus it also contains an improvement
> to the testsuite which now respect quotes/whitespace in
> commands' options.
>
> Luc Van Oostenryck (6):
>   add testcase for 'sparse -D M...'
>   fix: accept 'sparse -D M...'
>   testsuite: add test case for quoting of command's arguments
>   testsuite: respect command line's quotes & whitespaces
>   add test case for space within command line
>   fix: spaces in macro definition on the command line

Hi Luc,

I will be traveling for the whole next week.

No sure I will have time to get on it in the
follow week. I will take a look when I get back.

Chris
