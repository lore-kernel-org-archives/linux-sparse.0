From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: pre-process.c:569:18: error: bad constant expression
Date: Sat, 31 Dec 2005 11:50:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512311140290.3249@g5.osdl.org>
References: <20051231073006.GA3583@localhost> <Pine.LNX.4.64.0512311122400.3249@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:5045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932118AbVLaTup (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 14:50:45 -0500
In-Reply-To: <Pine.LNX.4.64.0512311122400.3249@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alecs King <alecsk@gmail.com>
Cc: linux-sparse <linux-sparse@vger.kernel.org>



On Sat, 31 Dec 2005, Linus Torvalds wrote:
> 
> And one of the things it doesn't like is variable-sized arrays. It will 
> actually correctly handle _some_ aspects of them (it should parse them and 
> so on), but never got it working properly even enough to make "sizeof" 
> work

Just in case somebody cares, a partial list of the problems I know 
about with variable-sized arrays as far as current sparse is concerned:

 - sparse just generates a list of symbols per block (and per function). 
   That's correct and proper for _all_ other kinds of variables, but not 
   for variable-sized ones. Why? Because those depend on where in the 
   block they are declared.

   Example:

	int main(int argc, char **argv)
	{
		char p[argc];
		argc++;
		char q[argc];
		return sizeof(p) + sizeof(q);
	}

   iow, we'd have to make variable declarations real statements in the 
   statement list. Which is by no means impossible, but it's a big change 
   for something that has little gain for _me_ (ie the kernel). So I'm 
   personally not very likely to do it.

   Side note: it's not just variable-sized arrays that need this. Any 
   initializers of mixed declarations also have this same issue. That's 
   another thing sparse warns about right now, as you already noticed.

 - "sizeof()" needs to generate a temporary variable. Example:

	int main(int argc, char **argv)
	{
		char p[argc++];
		return sizeof(p);
	}

   should obviously return the original value of "argc", and only evaluate 
   the expression once. The way sparse is set up right now, we parse the 
   expression properly, but we don't create the internal temporary result 
   for it.

   This is likely a fairly small change, though.

If those two problems are fixed, sparse probably could handle 
variable-sized arrays fairly well.

		Linus
