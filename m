From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/6] whitespace & '-D' option
Date: Sun, 17 Dec 2017 15:58:33 +0100
Message-ID: <20171217145831.osezlhc4hyewrsfq@ltop.local>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qkas1L8YkVorGbbH_cH_Azm_KEErrGv0LQJ9GcH_0fbvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39130 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757275AbdLQO6g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Dec 2017 09:58:36 -0500
Received: by mail-wm0-f50.google.com with SMTP id i11so25076669wmf.4
        for <linux-sparse@vger.kernel.org>; Sun, 17 Dec 2017 06:58:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkas1L8YkVorGbbH_cH_Azm_KEErrGv0LQJ9GcH_0fbvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Dec 15, 2017 at 02:15:17PM +0800, Christopher Li wrote:
> On Thu, Dec 14, 2017 at 1:15 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This series contains two fixes concerning the '-D' option
> > and white spaces. A a bonus it also contains an improvement
> > to the testsuite which now respect quotes/whitespace in
> > commands' options.
> >
> > Luc Van Oostenryck (6):
> >   add testcase for 'sparse -D M...'
> >   fix: accept 'sparse -D M...'
> >   testsuite: add test case for quoting of command's arguments
> >   testsuite: respect command line's quotes & whitespaces
> >   add test case for space within command line
> >   fix: spaces in macro definition on the command line
> 
> Hi Luc,
> 
> I will be traveling for the whole next week.
> 
> No sure I will have time to get on it in the
> follow week. I will take a look when I get back.

No worries.
-- Luc
