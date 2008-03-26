From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Interrupt context
Date: Wed, 26 Mar 2008 14:53:08 -0700
Message-ID: <70318cbf0803261453s8ec20c8m18bcf99a11e88ca@mail.gmail.com>
References: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com>
	 <200803250334.30713.tavi@cs.pub.ro>
	 <70318cbf0803241957l6b211d34t3cad51d587192501@mail.gmail.com>
	 <200803261443.18529.tavi@cs.pub.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:54321 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbYCZVxK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Mar 2008 17:53:10 -0400
Received: by wr-out-0506.google.com with SMTP id c48so3011092wra.1
        for <linux-sparse@vger.kernel.org>; Wed, 26 Mar 2008 14:53:09 -0700 (PDT)
In-Reply-To: <200803261443.18529.tavi@cs.pub.ro>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Octavian Purdila <tavi@cs.pub.ro>
Cc: Codrin Alexandru Grajdeanu <grcodal@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Mar 26, 2008 at 5:43 AM, Octavian Purdila <tavi@cs.pub.ro> wrote:
>  You don't need to change the build system, you got all the information you
>  need in the final deliverable of the build (vmlinux or the kernel module).

How do you write to the ELF object? Can you write to ELF64 then you shouldn't
have the size limit. I am not a big fan of loading everything into one big ELF
file. I image it would be useful to only load the module as you needed.

>
>  OK, so you think that the serializer approach is still the way to go then?
>

Depend on what you actually serialized. In the ideal world, you can save and
load the compiled linearized byte code with symbol informations. That way
you don't lose any information during the serialization.

Chris
