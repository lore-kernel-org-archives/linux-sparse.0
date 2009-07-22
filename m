From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 08:45:58 -0400
Message-ID: <4A670A06.1010605@garzik.org>
References: <200907182334.10900.kdudka@redhat.com> <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbZGVMqB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 08:46:01 -0400
In-Reply-To: <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Sat, Jul 18, 2009 at 2:34 PM, Kamil Dudka<kdudka@redhat.com> wrote:
>> Hello,
>>
>> I've probably encountered a bug within compile-i386.c. It generates
>> an infinite loop for 'while' statement. My testing example and proposed
>> patch are enclosed.
> 
> Adding Jeff to the CC list. The compile-i386.c is Jeff's pet project.
> The change looks good to me. I would like to give Jeff some time
> to comment it before I apply the patch.

Acked-by: Jeff Garzik <jgarzik@redhat.com>


