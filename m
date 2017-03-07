From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-next assertion failures on cygwin
Date: Tue, 7 Mar 2017 07:34:17 +0000
Message-ID: <CACXZuxduza+ZrR-Ki8di5ZYmSWP=632s9CrfC9GNGOOmj6wUGg@mail.gmail.com>
References: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com> <20170307063558.4itvt4mh327py6ls@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:33758 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbdCGHpI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 02:45:08 -0500
Received: by mail-it0-f53.google.com with SMTP id w124so5854611itb.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 23:43:46 -0800 (PST)
In-Reply-To: <20170307063558.4itvt4mh327py6ls@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On 7 March 2017 at 06:35, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Mar 06, 2017 at 10:17:36PM +0000, Ramsay Jones wrote:
> Dibyendu, are you seeing something like this on your environment?
>

On Windows I build my modified version using Visual C++, but as the
test driver is a shell script, I usually run the tests on a Linux
instance. I will run some tests individually and report back - but
note that I am synced with master not sparse-next.

Regards
Dibyendu
