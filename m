From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: bad asm goto ?
Date: Wed, 27 Oct 2010 23:33:52 -0700
Message-ID: <AANLkTi=8arp9k3Y-Jo6bkmGKUp60h7rZYRzQhpiHF-mT@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
	<AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
	<AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
	<AANLkTim6DeB4BAxQv87-mjLjabGrHKY1z+roEuHDznbF@mail.gmail.com>
	<AANLkTi=MJaTJ9qtispqhipRg615ojJmBTOg97d6Z5mZE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37455 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab0J1Gdx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Oct 2010 02:33:53 -0400
Received: by iwn10 with SMTP id 10so1993885iwn.19
        for <linux-sparse@vger.kernel.org>; Wed, 27 Oct 2010 23:33:52 -0700 (PDT)
In-Reply-To: <AANLkTi=MJaTJ9qtispqhipRg615ojJmBTOg97d6Z5mZE@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

On Wed, Oct 27, 2010 at 11:12 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Oct 27, 2010 at 7:45 PM, Harvey Harrison
> <harvey.harrison@gmail.com> wrote:
> \>
>> I'm afraid this didn't solve it for me when applying on top of v0.4.3,
>> if you have any other patches to try,
>> I'd be glad to test them out.
>
> What is your test case? The patch does work for me on the small test
> case provide by
> Dave. I am just wondering if you are running the same thing.
> If not, please let me know what you run and what is the error message.
>

Sorry about that, just ran again and had a leftover binary elsewhere
in my path, your patch does fix
the error, all that's left is the:

include/trace/events/kmem.h:45:1: error: incompatible types in
comparison expression (different address spaces)

Sorry for the noise.

Harvey
