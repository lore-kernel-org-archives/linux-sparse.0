From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Wed, 27 Jun 2007 21:59:58 +0900
Message-ID: <20070627125958.GA16758@daikokuya.co.uk>
References: <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org> <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk> <20070627121021.GQ7590@daikokuya.co.uk> <20070627123031.GO21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760702AbXF0NAN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070627123031.GO21478@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Al Viro wrote:-

> If you want to test ICE recognition, right now only the following places
> are checking for it:
> 	* bitfield width
> 	* __attribute__((aligned(<number>)))
> 	* __attribute__((address_space(<number>)))
> 	* [<index>] in designators within initializer list
> 	* [<index> ... <index>] - ditto, gccism
> 
> That's it.  We can use it elsewhere too, but that's a separate bunch of
> patches (trivial to do now).

Bah.  You don't escape that easily :)

extern int a;
struct b { unsigned int b1:(1,2); };
struct c { unsigned int c1: 1 ? 2: a++; };

are both invalid yet undiagnosed.

Neil.
