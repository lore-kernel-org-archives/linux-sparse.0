From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 12:44:22 +1030
Message-ID: <200812231244.22614.rusty@rustcorp.com.au>
References: <200812221606.13910.rusty@rustcorp.com.au> <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com> <20081222205750.GK28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52825 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbYLWCOZ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 21:14:25 -0500
In-Reply-To: <20081222205750.GK28946@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tuesday 23 December 2008 07:27:50 Al Viro wrote:
> The right solution is
> 	(*(typeof(v) __attribute__((address_space(0), force)) *)(&v))
> 
> Cast there will take a pointer to type of V and force-cast it to pointer to
> unqualified type of V.  *(cast)&v will do the obvious thing.  Will trim
> both the AS and noderef.

Thanks Al, that worked, but seems to tickle another bug (sparse 0.4.1, Ubuntu).

rusty@vivaldi:/tmp$ sparse foo.c
foo.c:11:20: warning: incorrect type in assignment (invalid types)
foo.c:11:20:    expected unknown type 11<noident>
foo.c:11:20:    got int

Here's my sample program now:

#define __percpu __attribute__((noderef, address_space(3)))

/* Turn v back into a normal var. */
#define convert(v) \
        (*(typeof(v) __attribute__((address_space(0), force)) *)(&v))

int main(int argc, char *argv)
{
        unsigned int __percpu x;

        convert(x) = 0;
        return 0;
}

