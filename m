From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 08:01:12 -0700
Message-ID: <1182956472.8970.35.camel@josh-work.beaverton.ibm.com>
References: <20070627103320.GA11047@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:45129 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbXF0PBN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:01:13 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5RF1C5m010157
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 11:01:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5RF1BPF257988
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:01:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5RF1B3w014414
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:01:11 -0600
In-Reply-To: <20070627103320.GA11047@localhost.sw.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, 2007-06-27 at 14:33 +0400, Alexey Dobriyan wrote:
> sparse silently accepts some peculiar combinations of declaration
> specifiers:
> 
> "typedef extern;" passes.
> 
> "void char a;" errors about void declaration, however,
> "extern void char a;" passes. Hey, "extern void a;" passes!
> 
> "char short a;" passes too. Ditto for "char float a;" and
> "char long a".
> 
> "typedef inline a;" passes.
> 
> Not sure how many different bugs there are here, though...

Several more:

int;
void;
int *;
void *;
static;
extern;
volatile;
static foo;
extern foo;
volatile foo;
int volatile;

- Josh Triplett
