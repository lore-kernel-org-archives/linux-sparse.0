From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Thu, 30 Jul 2015 07:45:18 -0400
Message-ID: <55BA0E4E.7000508@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbbG3LpU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Jul 2015 07:45:20 -0400
In-Reply-To: <20150730025502.GA1692@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On 07/29/2015 10:55 PM, Josh Triplett wrote:
> On Wed, Jul 29, 2015 at 08:26:41PM -0400, Tony Camuso wrote:
>> Allows building sparse to avert reporting semantic problems, e.g.
>> using sparse as a tokenizer to create a graph of KABI symbols and
>> their dependencies.
>>
>> Signed-off-by: Tony Camuso <tcamuso@redhat.com>
>
> This doesn't seem like something that should be determined at compile
> time.  Ideally, this should be determined at runtime.

I thought it would be less intrusive, since I don't know how useful
this would be to others.

If you prefer a switch, I will do that.

