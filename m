From: Christopher Li <sparse@chrisli.org>
Subject: Re: [0/4] inspector for sparse
Date: Fri, 2 Apr 2010 11:59:39 -0700
Message-ID: <w2j70318cbf1004021159y2fa50d58y62bd878c6355a972@mail.gmail.com>
References: <u2n70318cbf1004021136t65b4d8acmf8bfd7e18b410dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f173.google.com ([209.85.210.173]:58019 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0DBS7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Apr 2010 14:59:41 -0400
Received: by yxe3 with SMTP id 3so918685yxe.1
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2010 11:59:39 -0700 (PDT)
In-Reply-To: <u2n70318cbf1004021136t65b4d8acmf8bfd7e18b410dfe@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I add a treeview branch on sparse/chrisl so you can pull from it.

http://git.kernel.org/?p=3Ddevel/sparse/chrisl/sparse.git;a=3Dshortlog;=
h=3Drefs/heads/treeview

In fedora, you need to install gtk2-devel package to enable it.

Chris

On Fri, Apr 2, 2010 at 11:36 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> Hi,
>
> When I debug the enum int patch, some times I wish I have a better to=
ols
> to help me understand what is going on with the internal sprase data =
structure.
> There is debug_symbol() to help in some degree, but it does not show =
anything
> other than symbol type. E.g. expression and statments.
>
> test-parsing's output is more like assembly rather than a syntax tree=
=2E
> There is debug_symbol() but it only print out the symbol type. It doe=
s not
> go into expression. So the interesting stuff like expression =A0is ha=
rd to see.
>
> I want some thing it can display different types of C structure with =
expandable
> sub node for its member. Some thing like a file folder you can expand=
 it see its
> content.
>
> I first look at the GtkTreeView. It seems capable of doing what I wan=
t.
> The interface is cumbersome to use and I am really not a GUI person.
> So I build some custom tree model to simplify the interaction with GT=
K.
> That is the first patch in the series.
>
> The second patch of the series try to inspect C structure one at time=
=2E
> It is driven by the gtk tree model. It use a some glib function but i=
t does
> not have any GTK knowledge.
>
> The interface is generic enough that you should be able to do a curso=
r
> version from it without changing the code.
>
> The third patch adds the test-inspect program which launch a gtk wind=
ow.
> Oh, I did not bother to make the first two patches compile itself
> until this one.
>
> Please play with it. As always, feed back are welcome.
>
> The C structure inspection is rather incomplete currently. It is very=
 easy to
> expand it to show additional types and members. The last patch is an =
example.
> It is going to be very rewarding to extend the inspector. It does not
> require you have deep understanding of the sparse AST tree, it helps
> *you* to understand how sparse internal AST works.
>
> So patches are very welcome as well. Any one want to help?
>
> Chris
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
