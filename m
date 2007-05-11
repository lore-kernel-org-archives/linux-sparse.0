From: "Mike Goodwin" <mike.goodwin@cantab.net>
Subject: Re: Style checking
Date: Fri, 11 May 2007 03:25:02 -0700
Message-ID: <c38fc0de0705110325m52be51a2wbc309bea681345fc@mail.gmail.com>
References: <c38fc0de0704300030x6ab610acge10482904056d1db@mail.gmail.com>
	 <46378276.8060307@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:4339 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855AbXEKKZD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 May 2007 06:25:03 -0400
Received: by nz-out-0506.google.com with SMTP id o1so939270nzf
        for <linux-sparse@vger.kernel.org>; Fri, 11 May 2007 03:25:02 -0700 (PDT)
In-Reply-To: <46378276.8060307@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Sorry for the off the list email, was an accident. I replied to Josh:-

"Ah, I have to come clean here. I think my current approach is
incompatible with the sparse design - i.e. the front end just
generates a data structure. I have effectively being compiling
(hacking) in callbacks which listen for when a file is included, a
define is made, a type defined ... etc. The checks are implemented as
per/stream state machines, so they can check things are being done
correctly and in the correct place in a given file. This was the most
expedient way of using sparse with the minimum of understanding."

Now I am not sure that using the sparse approach (process first, check
abstract data structures later) is sufficient. The main difficulty I
am finding is that the information relevant to style checking is not
necessarily preserved by sparse, or where it is, it is difficult to
access in an ordered way. At the moment it looks like I will end with
a hybrid approach, which perhaps isn't very clean (and so is unlikely
to make it into the repo), if anyone has any feedback on how to
improve on this I would be happy to hear it. The two most
controversial modifications were:-

Function documenting comments:-
I made comments (actually just /**/ style comments) tokens, so they
are not dropped. Obviously this will break the parsing, so I modified
parse.c so that it would ignore them. Where token->next is accessed, I
replaced it with a function token_next(struct token *t) which skips
comment tokens. During external_declaration() I associate functions
with the previous comment, if the token before the declaration was a
comment. (I added a field to struct symbol to do the association).

File Layout:-
Its not obvious to me how it would be possible using the symbols_list
to access information about the streams and line numbers in a single
translation unit of:-
   - includes
   - comments
   - defines
   - typedefs
   - global variables
   - function prototypes
   - function definitions

How could all this information be accessed, preferably in a sequential manor?

regards,

Mike



On 5/1/07, Josh Triplett <josh@freedesktop.org> wrote:
> Mike Goodwin wrote:
> > I have begun modifying sparse (read: adding in various hooks to the
> > preprocessing and parsing stages) in order to be able to use it as a
> > style checker. Checking rules such as order of includes, function and
> > variable naming ... etc.
> >
> > The style checking is intended to be for linux/driver modules and as
> > far as I am aware the only two freely available c parsers which can
> > parse all the headers in the linux kernel are those that are part of
> > sparse and gcc. As sparse is a lot simpler to modify it seems the
> > logical choice
> >
> > So I was wondering:-
> >  1) if anyone had used sparse similarly?
>
> Not that I know of.
>
> >  2) would it ever be desirable to have this kind of feature as a part of sparse?
>
> Yes!  I'd love to see the frontend save enough information to do things
> like this, such as saving the tree of "#include"s.  I don't know if these
> kinds of rules should go in the Sparse backend or in another backend using
> libsparse; if the former, you'll need to include options to turn these
> checks on, and they should likely default to "off" because they will vary
> between projects.
>
> In addition to the warnings you suggest, I'd love to see a warning for "Header
> not self-contained": a header does not #include all the headers it needs, and
> instead relied on the inclusion of another header first.
>
> >  3) is there anything wrong with this approach?!
>
> Not that I can see; I look forward to seeing your patches.
>
> - Josh Triplett
>
>
>
