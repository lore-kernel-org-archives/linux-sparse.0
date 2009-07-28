From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/5] Add a --version option to sparse
Date: Tue, 28 Jul 2009 18:46:59 +0100
Message-ID: <4A6F3993.8000606@ramsay1.demon.co.uk>
References: <4A62395D.9000207@ramsay1.demon.co.uk>	 <70318cbf0907211757w1e0e3436hcc8b679c6de60804@mail.gmail.com>	 <4A6A0BF2.7080509@ramsay1.demon.co.uk> <70318cbf0907251234o6028d0adh8a470f40f373578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:44694 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753420AbZG1Rti (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 13:49:38 -0400
In-Reply-To: <70318cbf0907251234o6028d0adh8a470f40f373578@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Fri, Jul 24, 2009 at 12:30 PM, Ramsay
> Jones<ramsay@ramsay1.demon.co.uk> wrote:
>> $ git checkout master
>> $ git describe
>> 0.4.1-99-g37f041a
> 
> If works well if you are following the official branch. If you are working
> on your own, you might have some private tag. Then that will mess up
> the "git describe". My tag might not even look like a version number.
> 

True, but I don't see that as a problem. :)

>> However, you would not want sparse (the library) to force *all*
>> applications built with the library to handle the --version option
>> by printing the sparse (the program) version string and exiting!
> 
> That is what YOUR current patch do, no?
> 

Exactly. ;-)
I was describing what is wrong with the patch and how I intended to
fix it. Indeed, I have fixed it. However, since there is no interest
in it, I'll refrain from spaming the list. ;-)

ATB,
Ramsay Jones

