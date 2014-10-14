From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] compile-i386.c: don't ignore return value of write(2)
Date: Tue, 14 Oct 2014 05:14:29 +0200
Message-ID: <20141014031428.GA1009@thin>
References: <543C5A43.9@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42214 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbaJNDOe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Oct 2014 23:14:34 -0400
Content-Disposition: inline
In-Reply-To: <543C5A43.9@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Oct 14, 2014 at 12:03:31AM +0100, Ramsay Jones wrote:
> 
> Some versions of gcc (e.g. v4.8.2) complain about ignoring the return
> value of a call to the write(2) system call, since the system header
> files have marked its declaration with the warn_unused_result attribute.
> 
> In order to suppress the compiler warning, check the return value from
> 'write' and, if it indicates an error (a negative return value), exit
> the process using 'die' to display an error message. Replace a second
> call to 'write', which does not provoke a compiler warning, with similar
> code for consistency.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

That isn't the only way write() can fail; it can also do a partial
write, in which case you need to loop and write the rest.  You might
consider adding an xwrite() function which includes that logic.
(Alternatively, you could use standard C IO, which doesn't have that
problem.)

> 
> Hi Chris,
> 
> This is an (almost) minimal patch to suppress the compiler warning.
> You could drop the second hunk (and edit the commit message) if you
> prefer an absolutely minimal patch. :-D
> 
> ATB,
> Ramsay Jones
> 
>  compile-i386.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/compile-i386.c b/compile-i386.c
> index 88169ec..44b72ec 100644
> --- a/compile-i386.c
> +++ b/compile-i386.c
> @@ -732,7 +732,8 @@ static void emit_insn_atom(struct function *f, struct atom *atom)
>  			atom->insn,
>  			comment[0] ? "\t\t" : "", comment);
>  
> -	write(STDOUT_FILENO, s, strlen(s));
> +	if (write(STDOUT_FILENO, s, strlen(s)) < 0)
> +		die("can't write to stdout");
>  }
>  
>  static void emit_atom_list(struct function *f)
> @@ -742,9 +743,8 @@ static void emit_atom_list(struct function *f)
>  	FOR_EACH_PTR(f->atom_list, atom) {
>  		switch (atom->type) {
>  		case ATOM_TEXT: {
> -			ssize_t rc = write(STDOUT_FILENO, atom->text,
> -					   atom->text_len);
> -			(void) rc;	/* FIXME */
> +			if (write(STDOUT_FILENO, atom->text, atom->text_len) < 0)
> +				die("can't write to stdout");
>  			break;
>  		}
>  		case ATOM_INSN:
> -- 
> 2.1.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
