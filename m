From: Petr Muller <afri@afri.cz>
Subject: Detection of locking one lock twice
Date: Tue, 22 Dec 2009 01:09:27 +0100
Message-ID: <1261440567.5039.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mesias.m6.cz ([81.19.0.120]:60139 "EHLO mesias.m6.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbZLVATm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Dec 2009 19:19:42 -0500
Received: from [192.168.2.100] (ip4-95-82-131-225.cust.nbox.cz [95.82.131.225])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mesias.m6.cz (Postfix) with ESMTPSA id 558C5125406E
	for <linux-sparse@vger.kernel.org>; Tue, 22 Dec 2009 01:11:02 +0100 (CET)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I'm playing with sparse a bit, especially the context/locking problem
detecting stuff. I'm trying to create simple context updating
lock/unlock, everything works as I would expect except for this case
(I've reduced it as much as possible) :

#ifdef __CHECKER__
  #define __acquires(x) __attribute__((context (x, 0, 1)))
  #define __releases(x) __attribute__((context (x, 1, 0)))
  #define __acquire(x) __context__(x,1)
  #define __release(x) __context__(x,-1)
#else
(...)
#endif

(...)

void lock(void)
  __acquires(i)
{
  __acquire(i);
}

void unlock(void)
  __releases(i)
{
  __release(i);
}

void fction(int a)
{
  lock();
  lock();
  unlock();
  unlock();
}

int main(void){
  fction(1);
  return 0;
}

Sparse gives no warning in this code - I would expect that second call
to lock() would violate the 'in' limit of __acquires attribute, but it
does not. I'm wondering if this is actually a problem in sparse, or am I
doing something wrong? 

Thanks,

Petr

